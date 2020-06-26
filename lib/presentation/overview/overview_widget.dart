import 'package:cash_box/app/accounts_bloc/accounts_bloc.dart';
import 'package:cash_box/app/accounts_bloc/accounts_state.dart';
import 'package:cash_box/app/injection.dart';
import 'package:cash_box/app/receipts_bloc/bloc.dart';
import 'package:cash_box/core/platform/constants.dart';
import 'package:cash_box/domain/account/enteties/currencies.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/domain/core/usecases/currency/format_currency_use_case.dart';
import 'package:cash_box/domain/core/usecases/receipts/get_total_amount_of_receipts_use_case.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/base/screen_type_layout.dart';
import 'package:cash_box/presentation/base/sizing_information.dart';
import 'package:cash_box/presentation/base/width_constrained_widget.dart';
import 'package:cash_box/presentation/buckets/buckets_overview_widget.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:cash_box/presentation/statistics/overview_statistics/receipts_gauge_pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OverviewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: sl<ReceiptsBloc>(),
      builder: (context, state) {
        if (state is ReceiptsAvailableState) {
          if (state.receipts != null) {
            return _buildLoaded(context, state.receipts, state.month);
          } else {
            return LoadingWidget();
          }
        } else {
          return LoadingWidget();
        }
      },
    );
  }

  Widget _buildLoaded(
      BuildContext context, List<Receipt> receipts, DateTime month) {
    final incomeReceipts =
        receipts.where((e) => e.type == ReceiptType.income).toList();
    final outcomeReceipts =
        receipts.where((e) => e.type == ReceiptType.outcome).toList();

    if (receipts.isEmpty) {
      return _buildNoData();
    } else {
      return Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: SpacedScreenTypeLayout(
            mobile: WidthConstrainedWidget(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  _buildChart(month, incomeReceipts, outcomeReceipts),
                  _buildCards(context, incomeReceipts, outcomeReceipts),
                  SizedBox(height: 16.0),
                  BucketsOverviewWidget()
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget _buildNoData() {
    return Align(
      alignment: Alignment.center,
      child: Builder(
        builder: (context) =>
            Text(AppLocalizations.translateOf(context, "txt_no_data")),
      ),
    );
  }

  Widget _buildChart(DateTime month, List<Receipt> incomeReceipts,
      List<Receipt> outcomeReceipts) {
    return Container(
      child: ReceiptsGaugePieChart.fromReceipts(
        month,
        incomeReceipts,
        outcomeReceipts,
      ),
      constraints: BoxConstraints(maxHeight: 250),
    );
  }

  Widget _buildCards(BuildContext context, List<Receipt> incomeReceipts,
      List<Receipt> outcomeReceipts) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder(
          bloc: sl<AccountsBloc>(),
          builder: (context, state) {
            var currencySymbol = "";
            if (state is AccountAvailableState) {
              final currencyCode = currencySymbol = state.account.currencyCode;
              currencySymbol = currencySymbolFromCode(currencyCode);
            }

            return Row(
              children: [
                SizedBox(width: 16.0),
                _buildCardContainer(
                  _buildResultCard(
                    context,
                    incomeReceipts,
                    outcomeReceipts,
                    currencySymbol,
                  ),
                ),
                SizedBox(width: 16.0),
                _buildCardContainer(
                  _buildIncomesCard(
                    context,
                    incomeReceipts,
                    currencySymbol,
                  ),
                ),
                SizedBox(width: 16.0),
                _buildCardContainer(
                  _buildOutcomesCard(
                    context,
                    outcomeReceipts,
                    currencySymbol,
                  ),
                ),
                SizedBox(width: 16.0),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCardContainer(Widget card) {
    return ScreenTypeBuilder(
      builder: (screenType) => Container(
        constraints: BoxConstraints(minWidth: screenType == DeviceScreenType.mobile ? 200 : 245),
        child: card,
      ),
    );
  }

  Widget _buildResultCard(BuildContext context, List<Receipt> incomeReceipts,
      List<Receipt> outcomeReceipts, String currencySymbol) {
    final useCase = sl<GetTotalAmountOfReceiptsUseCase>();
    final resultAmount = useCase(incomeReceipts) - useCase(outcomeReceipts);

    final formattedAmount = sl<FormatCurrencyUseCase>().call(
        FormatCurrencyUseCaseParams(
            amount: resultAmount, symbol: currencySymbol));

    return _buildIncomesOutcomesCard(
      titleText: formattedAmount,
      subtitleText: AppLocalizations.translateOf(context, "txt_cash"),
      backgroundColor: Colors.white,
      textColor: Colors.black,
    );
  }

  Widget _buildOutcomesCard(BuildContext context, List<Receipt> outcomeReceipts,
      String currencySymbol) {
    final resultAmount = sl<GetTotalAmountOfReceiptsUseCase>()(outcomeReceipts);
    final formattedAmount = sl<FormatCurrencyUseCase>().call(
        FormatCurrencyUseCaseParams(
            amount: resultAmount, symbol: currencySymbol));

    return _buildIncomesOutcomesCard(
      titleText: formattedAmount,
      subtitleText:
          AppLocalizations.translateOf(context, "txt_outcomes").toUpperCase(),
      backgroundColor: outcomeColor,
    );
  }

  Widget _buildIncomesCard(BuildContext context, List<Receipt> incomeReceipts,
      String currencySymbol) {
    final resultAmount = sl<GetTotalAmountOfReceiptsUseCase>()(incomeReceipts);
    final formattedAmount = sl<FormatCurrencyUseCase>().call(
        FormatCurrencyUseCaseParams(
            amount: resultAmount, symbol: currencySymbol));

    return _buildIncomesOutcomesCard(
      titleText: formattedAmount,
      subtitleText:
          AppLocalizations.translateOf(context, "txt_incomes").toUpperCase(),
      backgroundColor: incomeColor,
    );
  }

  Widget _buildIncomesOutcomesCard(
      {@required String titleText,
      @required String subtitleText,
      @required Color backgroundColor,
      Color textColor = Colors.white}) {
    return _buildCard(
      color: backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleText,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24,
              color: textColor,
            ),
          ),
          SizedBox(height: 4),
          Text(
            subtitleText,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCard({@required Widget child, @required Color color}) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(8.0),
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: child,
      ),
    );
  }
}
