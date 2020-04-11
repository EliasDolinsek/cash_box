import 'package:cash_box/app/injection.dart';
import 'package:cash_box/app/receipts_bloc/bloc.dart';
import 'package:cash_box/core/platform/input_converter.dart';
import 'package:cash_box/domain/core/enteties/fields/field.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/fields/field_card_widget.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:cash_box/presentation/buckets/widgets/bucket_selection_widget.dart';
import 'package:cash_box/presentation/widgets/content_card_widget.dart';
import 'package:cash_box/presentation/receipts/widgets/receipt_type_selection_widget.dart';
import 'package:cash_box/presentation/widgets/responsive_widget.dart';
import 'package:cash_box/presentation/tags/widgets/tags_selection_widget.dart';
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
        leading: IconButton(
          icon: Icon(Icons.check),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    final receiptID = _addNewReceipt();
    return StreamBuilder(
      stream: sl<ReceiptsBloc>().state,
      builder: (_, AsyncSnapshot<ReceiptsState> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          if (data is ReceiptsAvailableState) {
            return _buildContentForReceiptFromReceiptsList(
                receiptID, data.receipts);
          } else if (data is ReceiptsErrorState) {
            return ErrorWidget(data.errorMessage);
          } else {
            return LoadingWidget();
          }
        } else {
          return LoadingWidget();
        }
      },
    );
  }

  String _addNewReceipt() {
    final receipt = Receipt.newReceipt(
      type: ReceiptType.outcome,
      creationDate: DateTime.now(),
      fields: fields,
      tagIDs: [],
    );

    sl<ReceiptsBloc>().dispatch(AddReceiptEvent(receipt));

    return receipt.id;
  }

  Widget _buildContentForReceiptFromReceiptsList(
      String receiptID, List<Receipt> receipts) {
    final receipt = receipts.firstWhere((element) => element.id == receiptID,
        orElse: () => null);
    if (receipt != null) {
      return ReceiptDetailsPage(receipt);
    } else {
      return LoadingWidget();
    }
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
  List<Field> fields;
  List<String> tagIds;
  ReceiptType receiptType;
  DateTime creationDate;

  @override
  void initState() {
    super.initState();
    receiptType = widget.receipt.type;
    creationDate = widget.receipt.creationDate;
    tagIds = widget.receipt.tagIDs;
    fields = widget.receipt.fields;
  }

  @override
  void dispose() {
    super.dispose();
    _updateReceipt();
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
        onFieldChanged: (update) {
          final index = fields.indexWhere((element) => element.id == update.id);
          fields.removeAt(index);
          fields.insert(index, update);
        },
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
        _receiptCreationDateSelection,
        SizedBox(height: 8.0),
        _tagSelection,
        SizedBox(height: 8.0),
        _bucketSelection
      ],
    );
  }

  Widget get _receiptCreationDateSelection {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.translateOf(context, "txt_date"),
          style: _titleStyle,
        ),
        ReceiptCreationDateSelectionWidget(
          initialDateTime: creationDate,
          onUpdate: (update) => creationDate = update,
        )
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
        SizedBox(height: 8.0),
        TagsSelectionWidget(
          initialTagIds: tagIds,
          onChange: (updatedTagIds) => tagIds = updatedTagIds,
        ),
      ],
    );
  }

  Widget get _bucketSelection {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.translateOf(context, "txt_bucket"),
          style: _titleStyle,
        ),
        SizedBox(height: 16.0),
        BucketSelectionWidget(
          receiptId: widget.receipt.id,
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
    return TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
  }

  void _updateReceipt() {
    final event = UpdateReceiptEvent(
      widget.receipt.id,
      type: receiptType,
      fields: fields,
      tagIDs: tagIds,
      creationDate: creationDate
    );

    sl<ReceiptsBloc>().dispatch(event);
  }
}

class ReceiptCreationDateSelectionWidget extends StatefulWidget {
  final Function(DateTime update) onUpdate;
  final DateTime initialDateTime;

  const ReceiptCreationDateSelectionWidget(
      {Key key, @required this.initialDateTime, @required this.onUpdate})
      : super(key: key);

  @override
  _ReceiptCreationDateSelectionWidgetState createState() =>
      _ReceiptCreationDateSelectionWidgetState();
}

class _ReceiptCreationDateSelectionWidgetState
    extends State<ReceiptCreationDateSelectionWidget> {
  DateTime dateTime;

  @override
  void initState() {
    super.initState();
    dateTime = widget.initialDateTime;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        InputConverter.dateFromValueAsReadableString(dateTime).toUpperCase(),
      ),
      onPressed: _showDateSelection,
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