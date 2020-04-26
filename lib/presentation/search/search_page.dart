import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/tags/tags_selection_page.dart';
import 'package:flutter/material.dart';

class FilterPage extends StatelessWidget {
  final Function(ReceiptType receiptType, List<String> tagIds) onChanged;

  const FilterPage({Key key, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.translateOf(context, "txt_filter")),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: FilterWidget(
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class FilterWidget extends StatefulWidget {
  final Function(ReceiptType receiptType, List<String> tagIds) onChanged;

  const FilterWidget({Key key, this.onChanged}) : super(key: key);

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {

  List<ReceiptType> receiptTypes = []..addAll(ReceiptType.values);
  List<String> tagIds = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 16.0),
        _buildReceiptTypeSelection(),
        SizedBox(height: 16.0),
        _buildTagsSelection(context),
      ],
    );
  }

  Widget _buildReceiptTypeSelection() {
    return Column(
      children: <Widget>[
        Text(
          AppLocalizations.translateOf(context, "txt_type"),
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 8.0),
        CheckboxListTile(
          value: receiptTypes.contains(ReceiptType.income),
          onChanged: (value) {
            if (receiptTypes.contains(ReceiptType.outcome)) {
              setState(() {
                if (value) {
                  receiptTypes.add(ReceiptType.income);
                } else {
                  receiptTypes.remove(ReceiptType.income);
                }
              });

              onChanged();
            }
          },
          title: Text(AppLocalizations.translateOf(context, "txt_income")),
        ),
        CheckboxListTile(
          value: receiptTypes.contains(ReceiptType.outcome),
          onChanged: (value) {
            if (receiptTypes.contains(ReceiptType.income)) {
              setState(() {
                if (value) {
                  receiptTypes.add(ReceiptType.outcome);
                } else {
                  receiptTypes.remove(ReceiptType.outcome);
                }
              });

              onChanged();
            }
          },
          title: Text(AppLocalizations.translateOf(context, "txt_outcome")),
        )
      ],
    );
  }

  void onChanged(){
    final receiptType = receiptTypes.length > 1 ? null : receiptTypes.first;
    widget.onChanged(receiptType, tagIds);
  }

  Widget _buildTagsSelection(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(
          AppLocalizations.translateOf(context, "txt_tags"),
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 8.0),
        TagsSelectionWidget(
          onChanged: (tagIds){
            this.tagIds = tagIds;
            onChanged();
          },
        )
      ],
    );
  }
}
