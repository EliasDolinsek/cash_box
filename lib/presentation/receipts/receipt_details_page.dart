import 'package:cash_box/domain/core/enteties/fields/field.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/fields/field_card_widget.dart';
import 'package:cash_box/presentation/widgets/responsive_widget.dart';
import 'package:flutter/material.dart';

class AddReceiptPage extends StatelessWidget {
  final List<Field> fields;

  const AddReceiptPage({Key key, this.fields = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.translateOf(context, "txt_new_receipt")),
        backgroundColor: Colors.white,
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    final receipt = Receipt.newReceipt(
      type: ReceiptType.outcome,
      creationDate: DateTime.now(),
      fields: fields,
      tagIDs: [],
    );

    return ReceiptDetailsPage(receipt);
  }
}

class ReceiptDetailsPage extends StatelessWidget {
  final Receipt receipt;
  final Function(Receipt update) onUpdate;

  const ReceiptDetailsPage(this.receipt, {Key key, this.onUpdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      child: ListView(children: _receiptFieldsAsItems()),
    );
  }

  List<Widget> _receiptFieldsAsItems() {
    final templateFields = receipt.fields.map((e) {
      return FieldCard(
        e,
        key: ValueKey(e),
        deletable: false,
        descriptionEditable: false,
        typeEditable: false,
      );
    }).toList();

    return _defaultReceiptFields..addAll(templateFields);
  }

  List<Widget> get _defaultReceiptFields {
    return <Widget>[
      creationDateField,
    ];
  }

  get creationDateField {
    final field = Field.newField(
        type: FieldType.date,
        description: "Receipt details",
        value: receipt.creationDate);

    return FieldCard(
      field,
      typeEditable: false,
      descriptionEditable: false,
      deletable: false,
      onFieldChanged: (update) {
        print(update);
      },
    );
  }
}
