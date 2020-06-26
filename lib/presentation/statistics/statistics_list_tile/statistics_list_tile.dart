import 'package:cash_box/app/accounts_bloc/accounts_bloc.dart';
import 'package:cash_box/app/accounts_bloc/accounts_state.dart';
import 'package:cash_box/app/injection.dart';
import 'package:cash_box/core/platform/constants.dart';
import 'package:cash_box/core/platform/entetie_converter.dart';
import 'package:cash_box/domain/account/enteties/currencies.dart';
import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/domain/core/enteties/tags/tag.dart';
import 'package:cash_box/domain/core/usecases/currency/format_currency_use_case.dart';
import 'package:cash_box/domain/core/usecases/receipts/get_incomes_outcomes_use_case.dart';
import 'package:cash_box/domain/core/usecases/receipts/get_total_amount_of_receipts_use_case.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BucketStatisticsListTile extends StatelessWidget {
  final Bucket bucket;
  final List<Receipt> receipts;

  const BucketStatisticsListTile({
    Key key,
    @required this.bucket,
    @required this.receipts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReceiptStatisticsListTile(
      name: bucket.name,
      receipts: _getReceipts(),
    );
  }

  List<Receipt> _getReceipts() => receipts
      .where((element) => bucket.receiptsIDs.contains(element.id))
      .toList();
}

class TagStatisticsListTile extends StatelessWidget {
  final Tag tag;
  final List<Receipt> receipts;

  const TagStatisticsListTile(
      {Key key, @required this.tag, @required this.receipts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReceiptStatisticsListTile(
      name: tag.name,
      receipts: _getReceipt(),
    );
  }

  List<Receipt> _getReceipt() =>
      receipts.where((element) => element.tagIDs.contains(tag.id)).toList();
}

class ReceiptStatisticsListTile extends StatelessWidget {
  final String name;
  final List<Receipt> receipts;

  const ReceiptStatisticsListTile(
      {Key key, @required this.name, @required this.receipts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: sl<AccountsBloc>(),
      builder: (context, state) {
        var currencySymbol = "";
        if (state is AccountAvailableState) {
          currencySymbol =
              currencySymbolFromCode(state.account?.currencyCode) ?? "";
        }

        return StatisticsListTile(
          title: name,
          trailing: _getTrailingAmountAsFormattedString(currencySymbol),
          data: _getStatisticsListTileData(currencySymbol),
        );
      },
    );
  }

  String _getTrailingAmountAsFormattedString(String currencySymbol) {
    final useCase = sl<GetTotalAmountOfReceiptsUseCase>();
    final amount =
        useCase.call(getIncomeReceipts()) - useCase.call(getOutcomeReceipts());

    final params = FormatCurrencyUseCaseParams(
      amount: amount,
      symbol: currencySymbol,
    );

    return sl<FormatCurrencyUseCase>().call(params);
  }

  List<StatisticsListTileData> _getStatisticsListTileData(
      String currencySymbol) {
    final incomesAmount =
        sl<GetTotalAmountOfReceiptsUseCase>()(getIncomeReceipts());
    final outcomesAmount =
        sl<GetTotalAmountOfReceiptsUseCase>()(getOutcomeReceipts());

    final incomesAmountAsString = sl<FormatCurrencyUseCase>().call(
        FormatCurrencyUseCaseParams(
            amount: incomesAmount, symbol: currencySymbol));

    final outcomesAmountAsString = sl<FormatCurrencyUseCase>().call(
        FormatCurrencyUseCaseParams(
            amount: outcomesAmount, symbol: currencySymbol));

    return StatisticsListTileData.fromGetIncomesOutcomesOfBucketUseCaseResult(
      getIncomesOutcomesOfBucketUseCaseResult(),
      incomesAmountAsString,
      outcomesAmountAsString,
      "",
    );
  }

  GetIncomesOutcomesOfBucketUseCaseResult
      getIncomesOutcomesOfBucketUseCaseResult() =>
          sl<GetIncomesOutcomesUseCase>()
              .call(GetIncomesOutcomesUseCaseParams(receipts));

  List<Receipt> getIncomeReceipts() =>
      getIncomesOutcomesOfBucketUseCaseResult().incomeReceipts;

  List<Receipt> getOutcomeReceipts() =>
      getIncomesOutcomesOfBucketUseCaseResult().outcomeReceipts;
}

class StatisticsListTile extends StatelessWidget {
  final double spacing, height;
  final String title, trailing;
  final List<StatisticsListTileData> data;

  const StatisticsListTile(
      {Key key,
      this.title = "",
      this.trailing = "",
      @required this.data,
      this.spacing = 8,
      this.height = 12})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              _getTitle(context),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Text(
            trailing,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: LayoutBuilder(
          builder: (context, constraints) => ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 10),
            child: _buildSubtitle(),
          ),
        ),
      ),
    );
  }

  Widget _buildSubtitle() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final progressIndicators =
            _getStatisticsProgressIndicators(constraints.maxWidth);
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: progressIndicators,
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: progressIndicators
                  .map(
                    (e) => Container(
                      width: e.width,
                      child: Text(
                        e.statisticsListTileData.text,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  )
                  .toList(),
            )
          ],
        );
      },
    );
  }

  List<_StatisticsProgressIndicator> _getStatisticsProgressIndicators(
      double maxWidth) {
    return data.map((e) {
      if (e.count == 0) {
        return _StatisticsProgressIndicator(
          width: maxWidth,
          height: height,
          color: e.color,
          statisticsListTileData: e,
        );
      } else {
        final appliedSpacing = data.length <= 1 ? 0 : spacing;

        double widthAsPercent = (100 / _getMaxCount() * e.count);
        double width = widthAsPercent / 100 * (maxWidth - appliedSpacing);

        return _StatisticsProgressIndicator(
          width: width,
          height: height,
          color: e.color,
          statisticsListTileData: e,
        );
      }
    }).toList();
  }

  double _getMaxCount() {
    var count = 0.0;
    data.forEach((element) => count += element.count);
    return count;
  }

  String _getTitle(BuildContext context) {
    if (title != null && title.isNotEmpty) {
      return title;
    } else {
      return AppLocalizations.translateOf(context, "unnamed");
    }
  }
}

class StatisticsListTileData {
  final double count;
  final String text;
  final Color color;

  StatisticsListTileData(this.count, {this.text, this.color});

  static List<StatisticsListTileData>
      fromGetIncomesOutcomesOfBucketUseCaseResult(
          GetIncomesOutcomesOfBucketUseCaseResult result,
          [String incomesText = "",
          String outcomesText = "",
          String neutralText = ""]) {
    List<StatisticsListTileData> list = [];

    if (result.incomeReceiptsAmount == 0 && result.outcomeReceiptsAmount == 0) {
      list.add(StatisticsListTileData.neutral(0, text: neutralText));
      return list;
    }

    if (result.incomeReceiptsAmount != 0) {
      list.add(
        StatisticsListTileData.income(result.incomeReceiptsAmount,
            text: incomesText),
      );
    }

    if (result.outcomeReceiptsAmount != 0) {
      list.add(StatisticsListTileData.outcome(result.outcomeReceiptsAmount,
          text: outcomesText));
    }

    return list;
  }

  factory StatisticsListTileData.income(double count, {String text}) =>
      StatisticsListTileData(count, text: text, color: incomeColor);

  factory StatisticsListTileData.outcome(double count, {String text}) =>
      StatisticsListTileData(count, text: text, color: outcomeColor);

  factory StatisticsListTileData.neutral(double count, {String text}) =>
      StatisticsListTileData(count, text: text, color: Colors.grey);
}

class _StatisticsProgressIndicator extends StatelessWidget {
  final StatisticsListTileData statisticsListTileData;
  final double width, height, borderRadius;
  final Color color;

  const _StatisticsProgressIndicator(
      {Key key,
      @required this.width,
      @required this.height,
      @required this.color,
      @required this.statisticsListTileData,
      this.borderRadius = 8})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
      ),
    );
  }
}
