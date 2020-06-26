import 'package:cash_box/app/injection.dart';
import 'package:cash_box/core/platform/constants.dart'
    show incomeColor, outcomeColor;
import 'package:cash_box/core/platform/entetie_converter.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/domain/core/usecases/receipts/get_total_amount_of_receipts_use_case.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'dart:math' show pi;

class ReceiptsGaugePieChart extends StatelessWidget {
  final DateTime month;
  final List<ReceiptSegment> segments;

  const ReceiptsGaugePieChart(
      {Key key, @required this.month, @required this.segments})
      : super(key: key);

  factory ReceiptsGaugePieChart.fromReceipts(
    DateTime receiptMonth,
    List<Receipt> incomeReceipts,
    List<Receipt> outcomeReceipts,
  ) {
    final incomesAmount =
        sl<GetTotalAmountOfReceiptsUseCase>().call(incomeReceipts);
    final outcomesAmount =
        sl<GetTotalAmountOfReceiptsUseCase>().call(outcomeReceipts);

    var segments = [ReceiptSegment.empty()];
    if (incomesAmount != 0.0 || outcomesAmount != 0.0) {
      segments = [
        ReceiptSegment(ReceiptType.income, incomesAmount),
        ReceiptSegment(ReceiptType.outcome, outcomesAmount)
      ];
    }

    return ReceiptsGaugePieChart(
      month: receiptMonth,
      segments: segments,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        charts.PieChart(
          getSeries(context),
          animate: false,
          defaultRenderer: charts.ArcRendererConfig(
            arcWidth: 30,
            startAngle: 4 / 5 * pi,
            arcLength: 7 / 5 * pi,
          ),
        ),
        Center(
          child: Text(
            getMonthAsReadableReceiptMonth(month),
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }

  List<charts.Series> getSeries(BuildContext context) => [
        charts.Series<ReceiptSegment, String>(
            id: "",
            data: segments,
            domainFn: (segment, _) => segment.receiptTypeAsString(context),
            measureFn: (segment, _) => segment.amount ?? 1,
            colorFn: (segment, _) => segment.color)
      ];
}

class ReceiptSegment {
  final ReceiptType receiptType;
  final double amount;

  ReceiptSegment(this.receiptType, this.amount);

  String receiptTypeAsString(BuildContext context) =>
      receiptType != null ? getReceiptTypeAsString(context, receiptType) : "";

  charts.Color get color {
    if (receiptType == null) return charts.ColorUtil.fromDartColor(Colors.grey);
    return receiptType == ReceiptType.income
        ? charts.ColorUtil.fromDartColor(incomeColor)
        : charts.ColorUtil.fromDartColor(outcomeColor);
  }

  factory ReceiptSegment.empty() => ReceiptSegment(null, null);
}
