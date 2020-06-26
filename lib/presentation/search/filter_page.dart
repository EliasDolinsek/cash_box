import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/receipts/widgets/receipt_type_selection_widget.dart';
import 'package:cash_box/presentation/tags/tags_selection_page.dart';
import 'package:cash_box/presentation/tags/widgets/tags_selection_widget.dart';
import 'package:flutter/material.dart';

class FilterPage extends StatelessWidget {
  final Function(ReceiptType receiptType, List<String> tagIds) onChanged;

  final List<String> selectedTagIds;
  final ReceiptType selectedReceiptType;

  const FilterPage(
      {Key key, this.onChanged, this.selectedTagIds, this.selectedReceiptType})
      : super(key: key);

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
          selectedReceiptType: selectedReceiptType,
          selectedTagIds: selectedTagIds,
        ),
      ),
    );
  }
}

class FilterWidget extends StatefulWidget {
  final List<String> selectedTagIds;
  final ReceiptType selectedReceiptType;
  final Function(ReceiptType receiptType, List<String> tagIds) onChanged;

  const FilterWidget(
      {Key key, this.onChanged, this.selectedTagIds, this.selectedReceiptType})
      : super(key: key);

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  ReceiptType receiptType;
  List<String> selectedTagIds = [];

  @override
  void initState() {
    super.initState();

    receiptType = widget.selectedReceiptType;
    selectedTagIds = widget.selectedTagIds ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      _buildReceiptTypeSelection(),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TagsSelectionBarWidget(
          initialTagIds: selectedTagIds,
          onChange: (update){
            this.selectedTagIds = update;
            widget.onChanged(receiptType, selectedTagIds);
          },
        ),
      )
    ];

    return ListView.separated(
      shrinkWrap: true,
      itemCount: items.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) => items[index],
    );
  }

  Widget _buildReceiptTypeSelection() {
    return Column(
      children: <Widget>[
        ReceiptTypeSelectionWidget(
          initialReceiptType: receiptType,
          noneSelectable: true,
          onChange: (type) {
            receiptType = type;
            widget.onChanged(receiptType, selectedTagIds);
          },
        ),
      ],
    );
  }
}
