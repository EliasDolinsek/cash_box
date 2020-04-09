import 'package:cash_box/app/injection.dart';
import 'package:cash_box/app/tags_bloc/bloc.dart';
import 'package:cash_box/core/platform/input_converter.dart';
import 'package:cash_box/domain/core/enteties/fields/field.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/fields/field_card_widget.dart';
import 'package:cash_box/presentation/widgets/content_card_widget.dart';
import 'package:cash_box/presentation/widgets/receipts/receipt_type_selection_widget.dart';
import 'package:cash_box/presentation/widgets/responsive_widget.dart';
import 'package:cash_box/presentation/widgets/tags/tags_selection_widget.dart';
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

class ReceiptDetailsPage extends StatefulWidget {
  final Receipt receipt;
  final Function(Receipt update) onUpdate;

  const ReceiptDetailsPage(this.receipt, {Key key, this.onUpdate})
      : super(key: key);

  @override
  _ReceiptDetailsPageState createState() => _ReceiptDetailsPageState();
}

class _ReceiptDetailsPageState extends State<ReceiptDetailsPage> {

  List<String> tagIds;
  ReceiptType receiptType;
  DateTime creationDate;

  @override
  void initState() {
    super.initState();
    receiptType = widget.receipt.type;
    creationDate = widget.receipt.creationDate;
    tagIds = widget.receipt.tagIDs;
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      child: ListView(
        shrinkWrap: true,
        children: _receiptFieldsAsItems(),
      ),
    );
  }

  List<Widget> _receiptFieldsAsItems() {
    final templateFields = widget.receipt.fields.map<Widget>((e) {
      return FieldCard(
        e,
        key: ValueKey(e),
        deletable: false,
        descriptionEditable: false,
        typeEditable: false,
      );
    }).toList();

    return templateFields..insert(0, _defaultReceiptFields);
  }

  Widget get _defaultReceiptFields {
    return TitledListContentCardWidget(
      title: Text(
        AppLocalizations.translateOf(context, "txt_receipt_details"),
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
      items: [
        _receiptTypeSelection,
        SizedBox(height: 8.0),
        ReceiptCreationDateSelection(
          initialDateTime: creationDate,
          onUpdate: (update) => creationDate = update,
        ),
        SizedBox(height: 8.0),
        _tagSelection
      ],
    );
  }

  Widget get _tagSelection {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.translateOf(context, "txt_tags"),
          style: _titleStyle,
        ),
        SizedBox(height: 16.0),
        TagsSelectionWidget(
          initialTagIds: tagIds,
          onChange: (updatedTagIds) => tagIds = updatedTagIds,
        )
      ],
    );
  }

  Widget get _receiptTypeSelection {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.translateOf(context, "txt_type"),
          style: _titleStyle,
        ),
        ReceiptTypeSelectionWidget(
          initialReceiptType: widget.receipt.type,
          onChange: (update) {
            receiptType = update;
          },
        ),
      ],
    );
  }

  TextStyle get _titleStyle {
    return TextStyle(fontWeight: FontWeight.bold);
  }
}

class ReceiptCreationDateSelection extends StatefulWidget {
  final Function(DateTime update) onUpdate;
  final DateTime initialDateTime;

  const ReceiptCreationDateSelection(
      {Key key, @required this.initialDateTime, @required this.onUpdate})
      : super(key: key);

  @override
  _ReceiptCreationDateSelectionState createState() =>
      _ReceiptCreationDateSelectionState();
}

class _ReceiptCreationDateSelectionState
    extends State<ReceiptCreationDateSelection> {
  DateTime dateTime;

  @override
  void initState() {
    super.initState();
    dateTime = widget.initialDateTime;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.translateOf(context, "txt_date"),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        MaterialButton(
          child: Text(
            InputConverter.dateFromValueAsReadableString(dateTime),
          ),
          onPressed: _showDateSelection,
        ),
      ],
    );
  }

  void _showDateSelection() async {
    final result = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(1900),
      lastDate: DateTime(2099),
    );

    if (result != null && result != dateTime) {
      setState(() => dateTime = result);
      if (widget.onUpdate != null) widget.onUpdate(dateTime);
    }
  }
}
