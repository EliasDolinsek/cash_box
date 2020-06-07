import 'package:cash_box/app/buckets_bloc/bloc.dart';
import 'package:cash_box/app/injection.dart';
import 'package:cash_box/app/receipts_bloc/bloc.dart';
import 'package:cash_box/core/platform/input_converter.dart';
import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:cash_box/domain/core/enteties/fields/field.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/base/width_constrained_widget.dart';
import 'package:cash_box/presentation/fields/field_card_widget.dart';
import 'package:cash_box/presentation/settings/dialogs/delete_dialog.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:cash_box/presentation/buckets/widgets/bucket_selection_widget.dart';
import 'package:cash_box/presentation/receipts/widgets/receipt_type_selection_widget.dart';
import 'package:cash_box/presentation/tags/widgets/tags_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddReceiptPage extends StatelessWidget {
  final List<Field> fields;

  const AddReceiptPage({Key key, this.fields = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.translateOf(context, "txt_new_receipt")),
        backgroundColor: Colors.white,
        leading: Container(
          width: 0,
          height: 0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: Icon(Icons.check),
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    final receiptID = _addNewReceipt();
    return BlocBuilder(
      bloc: sl<ReceiptsBloc>(),
      builder: (context, state) {
        if (state is ReceiptsAvailableState) {
          if (state.receipts != null) {
            return _buildContentForReceiptFromReceiptsList(
                receiptID, state.receipts);
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
      return ReceiptDetailsWidget(receipt);
    } else {
      return LoadingWidget();
    }
  }
}

class EditReceiptPage extends StatelessWidget {
  final String receiptId;

  const EditReceiptPage({Key key, @required this.receiptId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          AppLocalizations.translateOf(context, "txt_edit_receipt"),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () async {
              final result = await showDialog(
                context: context,
                builder: (context) => DeleteDialog(),
              );

              if(result != null && result){
                _deleteReceipt(context);
              }
            },
          )
        ],
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return BlocBuilder(
      bloc: sl<ReceiptsBloc>(),
      builder: (context, state) {
        if (state is ReceiptsAvailableState) {
          if (state.receipts != null) {
            return _buildContentForReceiptFromReceiptsList(
                context, receiptId, state.receipts);
          } else {
            return LoadingWidget();
          }
        } else {
          return LoadingWidget();
        }
      },
    );
  }

  Widget _buildContentForReceiptFromReceiptsList(
      BuildContext context, String receiptID, List<Receipt> receipts) {
    final receipt = receipts.firstWhere((element) => element.id == receiptID,
        orElse: () => null);

    return Center(
      child: Builder(
        builder: (_) {
          if (receipt != null) {
            return ReceiptDetailsWidget(receipt);
          } else {
            return ErrorWidget(
              AppLocalizations.translateOf(
                  context, "txt_could_not_load_receipt"),
            );
          }
        },
      ),
    );
  }

  void _deleteReceipt(BuildContext context) {
    final event = RemoveReceiptEvent(receiptId);
    sl<ReceiptsBloc>().dispatch(event);
    Navigator.of(context).pop();
  }
}

class ReceiptDetailsWidget extends StatefulWidget {
  final Receipt receipt;

  const ReceiptDetailsWidget(this.receipt, {Key key}) : super(key: key);

  @override
  _ReceiptDetailsWidgetState createState() => _ReceiptDetailsWidgetState();
}

class _ReceiptDetailsWidgetState extends State<ReceiptDetailsWidget> {
  List<Field> fields;
  List<String> tagIds;
  ReceiptType receiptType;
  DateTime creationDate;
  Bucket selectedBucket;

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
    _updateSelectedBucket();
  }

  @override
  Widget build(BuildContext context) {
    return WidthConstrainedWidget(
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) => _receiptFieldsAsItems()[index],
        separatorBuilder: (context, index) => Divider(),
        itemCount: _receiptFieldsAsItems().length,
      ),
    );
  }

  List<Widget> _receiptFieldsAsItems() {
    final templateFields = widget.receipt.fields.map<Widget>((e) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: FieldWidget(
          e,
          key: ValueKey(e),
          deletable: false,
          descriptionEditable: false,
          typeEditable: false,
          onFieldChanged: (update) {
            final index =
                fields.indexWhere((element) => element.id == update.id);
            fields.removeAt(index);
            fields.insert(index, update);
          },
        ),
      );
    }).toList();

    return templateFields..insertAll(0, _defaultReceiptFields);
  }

  List<Widget> get _defaultReceiptFields {
    return [
      ReceiptTypeSelectionWidget(
        initialReceiptType: widget.receipt.type,
        onChange: (update) {
          receiptType = update;
        },
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ReceiptCreationDateSelectionWidget(
          initialDateTime: creationDate,
          onUpdate: (update) => creationDate = update,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TagsSelectionBarWidget(
          initialTagIds: tagIds,
          onChange: (updatedTagIds) => tagIds = updatedTagIds,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: BlocBuilder(
          bloc: sl<BucketsBloc>(),
          builder: (context, state) {
            if (state is BucketsAvailableState) {
              if (state.buckets != null) {
                return BucketSelectionWidget(
                  initialSelectedBucket:
                      selectedBucket ?? _getSelectedBucket(state.buckets),
                  onUpdated: (oldBucket, newBucket) {
                    _removeReceiptFromBucket(oldBucket);
                    selectedBucket = newBucket;
                  },
                );
              } else {
                return LoadingWidget();
              }
            } else {
              return LoadingWidget();
            }
          },
        ),
      )
    ];
  }

  Bucket _getSelectedBucket(List<Bucket> buckets) {
    return buckets.firstWhere(
        (element) => element.receiptsIDs.contains(widget.receipt.id),
        orElse: () => null);
  }

  void _updateReceipt() {
    final event = UpdateReceiptEvent(
      widget.receipt.id,
      type: receiptType,
      fields: fields,
      tagIDs: tagIds,
      creationDate: creationDate,
    );

    sl<ReceiptsBloc>().dispatch(event);
  }

  void _updateSelectedBucket() {
    if (selectedBucket != null) {
      final receiptIds = [widget.receipt.id]
        ..addAll(selectedBucket.receiptsIDs ?? []);
      final event =
          UpdateBucketEvent(selectedBucket.id, receiptIDs: receiptIds);
      sl<BucketsBloc>().dispatch(event);
    }
  }

  void _removeReceiptFromBucket(Bucket bucket) {
    if (bucket != null) {
      final receiptIds = <String>[]
        ..addAll(bucket.receiptsIDs)
        ..remove(widget.receipt.id);
      final event = UpdateBucketEvent(bucket.id, receiptIDs: receiptIds);
      sl<BucketsBloc>().dispatch(event);
    }
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          InputConverter.dateFromValueAsReadableString(dateTime).toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        IconButton(
          icon: Icon(Icons.edit),
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
