import 'package:cash_box/app/injection.dart';
import 'package:cash_box/core/platform/constants.dart';
import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/domain/core/enteties/tags/tag.dart';
import 'package:cash_box/domain/core/usecases/receipts/get_incomes_outcomes_use_case.dart';
import 'package:flutter/material.dart';

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
    return StatisticsListTile(
      data: _getStatisticsListTileData(),
      trailing: "10€",
      title: bucket.name,
    );
  }

  List<StatisticsListTileData> _getStatisticsListTileData() {
    final params =
        GetIncomesOutcomesUseCaseParams(bucket.receiptsIDs, receipts);
    final result = sl<GetIncomesOutcomesUseCase>().call(params);

    return StatisticsListTileData.fromGetIncomesOutcomesOfBucketUseCaseResult(
        result, "INCOMES TOOD", "OUTCOMES TODO", "0€TODO");
  }
}

class TagStatisticsListTile extends StatelessWidget {
  final Tag tag;
  final List<Receipt> receipts;

  const TagStatisticsListTile(
      {Key key, @required this.tag, @required this.receipts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatisticsListTile(
      data: _getStatisticsListTileData(),
      title: tag.name,
      spacing: 8,
      trailing: "10€",
    );
  }

  List<StatisticsListTileData> _getStatisticsListTileData() {
    final tagReceipts =
        receipts.where((element) => element.tagIDs.contains(tag.id)).toList();

    final List<String> receiptIds = receipts
        .where((element) => element.tagIDs.contains(tag.id))
        .map((e) => e.id)
        .toList();

    final params = GetIncomesOutcomesUseCaseParams(receiptIds, tagReceipts);
    final result = sl<GetIncomesOutcomesUseCase>().call(params);

    return StatisticsListTileData.fromGetIncomesOutcomesOfBucketUseCaseResult(
        result, "INCOMES TOOD", "OUTCOMES TODO", "0€TODO");
  }
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
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
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
