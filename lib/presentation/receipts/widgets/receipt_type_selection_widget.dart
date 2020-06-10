import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:flutter/material.dart';

class ReceiptTypeSelectionWidget extends StatefulWidget {
  final ReceiptType initialReceiptType;
  final Function(ReceiptType type) onChange;
  final bool noneSelectable;

  const ReceiptTypeSelectionWidget(
      {Key key, this.onChange, this.initialReceiptType = ReceiptType.income, this.noneSelectable = false})
      : super(key: key);

  @override
  _ReceiptTypeSelectionWidgetState createState() =>
      _ReceiptTypeSelectionWidgetState();
}

class _ReceiptTypeSelectionWidgetState
    extends State<ReceiptTypeSelectionWidget> {
  ReceiptType _receiptType;

  @override
  void initState() {
    super.initState();
    _receiptType = widget.initialReceiptType;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        CheckboxListTile(
          title: Text(
            AppLocalizations.translateOf(context, "txt_income"),
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          onChanged: (value) {
            if (value) {
              _updateReceiptType(ReceiptType.income);
            }
          },
          value: _receiptType == ReceiptType.income,
        ),
        CheckboxListTile(
          title: Text(
            AppLocalizations.translateOf(context, "txt_outcome"),
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          onChanged: (value) {
            if (value) {
              _updateReceiptType(ReceiptType.outcome);
            }
          },
          value: _receiptType == ReceiptType.outcome,
        ),
        _buildNoneSelectable()
      ],
    );
  }

  Widget _buildNoneSelectable(){
    if(widget.noneSelectable){
      return Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: MaterialButton(
          onPressed: () => _updateReceiptType(null),
          child: Text(AppLocalizations.translateOf(context, "btn_select_none")),
        ),
      );
    } else {
      return Container(width: 0, height: 0);
    }
  }

  void _updateReceiptType(ReceiptType type) {
    if (_receiptType != type) {
      setState(() {
        _receiptType = type;
        if (widget.onChange != null) widget.onChange(_receiptType);
      });
    }
  }
}
