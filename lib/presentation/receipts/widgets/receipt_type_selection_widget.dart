import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:flutter/material.dart';

class ReceiptTypeSelectionWidget extends StatefulWidget {
  final ReceiptType initialReceiptType;
  final Function(ReceiptType type) onChange;

  const ReceiptTypeSelectionWidget(
      {Key key, this.onChange, this.initialReceiptType = ReceiptType.income})
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
      ],
    );
    return Row(
      children: <Widget>[
        _incomeChip,
        SizedBox(width: 8.0),
        _outcomeChip,
      ],
    );
  }

  get _incomeChip {
    return ChoiceChip(
      label: Text(AppLocalizations.translateOf(context, "txt_income")),
      selected: _receiptType == ReceiptType.income,
      onSelected: (value) {
        if (value) {
          _updateReceiptType(ReceiptType.income);
        }
      },
      backgroundColor: Colors.white,
      labelStyle: TextStyle(color: Colors.black),
      avatar: CircleAvatar(
        child: Icon(Icons.file_download, color: Colors.black),
        backgroundColor: Colors.white,
      ),
    );
  }

  get _outcomeChip {
    return ChoiceChip(
      label: Text(AppLocalizations.translateOf(context, "txt_outcome")),
      selected: _receiptType == ReceiptType.outcome,
      onSelected: (value) {
        if (value) {
          _updateReceiptType(ReceiptType.outcome);
        }
      },
      backgroundColor: Colors.white,
      labelStyle: TextStyle(color: Colors.black),
      avatar: CircleAvatar(
        child: Icon(Icons.file_upload, color: Colors.black),
        backgroundColor: Colors.white,
      ),
    );
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
