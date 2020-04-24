import 'package:cash_box/app/injection.dart';
import 'package:cash_box/app/receipt_month_bloc/bloc.dart';
import 'package:cash_box/app/receipts_bloc/bloc.dart';
import 'package:cash_box/core/platform/constants.dart';
import 'package:cash_box/core/platform/entetie_converter.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt_month.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/search/receipts_overview_widget.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:cash_box/presentation/statistics/receipts_gauge_pie_chart.dart';
import 'package:cash_box/presentation/widgets/default_card.dart';
import 'package:cash_box/presentation/widgets/responsive_widget.dart';
import 'package:flutter/material.dart';

class OverviewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ReceiptsState>(
      stream: sl<ReceiptsBloc>().state,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          if (data is ReceiptsAvailableState) {
            return _buildLoaded(context, data.receipts, data);
          } else if (data is ReceiptsInReceiptMonthAvailableState) {
            return _buildLoaded(context, data.receipts, data);
          } else if (data is ReceiptsErrorState) {
            _loadReceipts();
            return Expanded(
              child: Center(
                child: ErrorWidget(data.errorMessage),
              ),
            );
          } else {
            _loadReceipts();
            return _buildLoading();
          }
        } else {
          return _buildLoading();
        }
      },
    );
  }

  void _loadReceipts() async {
    final state = await sl<ReceiptMonthBloc>().state.first;
    if (state is ReceiptMonthAvailableState) {
      final receiptMonth = ReceiptMonth(state.month);
      sl<ReceiptsBloc>().dispatch(GetReceiptsInReceiptMonthEvent(receiptMonth));
    }
  }

  Widget _buildLoaded(
      BuildContext context, List<Receipt> receipts, ReceiptsState state) {
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
          child: ResponsiveWidget(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                _buildChart(incomeReceipts, outcomeReceipts),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _buildIncomesOutcomesCards(
                      context, incomeReceipts, outcomeReceipts),
                ),
                SizedBox(height: 16.0),
                ReceiptsOverviewWidget(
                  receipts: receipts,
                  onTap: (receipt) => Navigator.pushNamed(
                    context,
                    "/editReceipt",
                    arguments: receipt.id,
                  ),
                )
              ],
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

  Widget _buildChart(
      List<Receipt> incomeReceipts, List<Receipt> outcomeReceipts) {
    return Container(
      child: ReceiptsGaugePieChart.fromReceipts(
        incomeReceipts,
        outcomeReceipts,
      ),
      constraints: BoxConstraints(maxHeight: 250),
    );
  }

  Widget _buildIncomesOutcomesCards(BuildContext context,
      List<Receipt> incomeReceipts, List<Receipt> outcomeReceipts) {
    return Row(
      children: [
        Expanded(
          child: _buildIncomesCard(context, incomeReceipts),
          flex: 5,
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: _buildOutcomesCard(context, outcomeReceipts),
          flex: 5,
        )
      ],
    );
  }

  Widget _buildOutcomesCard(
      BuildContext context, List<Receipt> outcomeReceipts) {
    return _buildIncomesOutcomesCard(
      child: Column(
        children: [
          Text(
            "${totalAmountOfReceipts(outcomeReceipts)}",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
          ),
          SizedBox(height: 4),
          Text(
            AppLocalizations.translateOf(context, "txt_outcomes").toUpperCase(),
            style: TextStyle(
              color: incomeColor,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildIncomesCard(BuildContext context, List<Receipt> incomeReceipts) {
    return _buildIncomesOutcomesCard(
      child: Column(
        children: [
          Text(
            "${totalAmountOfReceipts(incomeReceipts)}",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
          ),
          SizedBox(height: 4),
          Text(
            AppLocalizations.translateOf(context, "txt_incomes").toUpperCase(),
            style: TextStyle(
              color: outcomeColor,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildIncomesOutcomesCard({@required Widget child}) {
    return DefaultCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: child,
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: LoadingWidget(),
    );
  }
}
