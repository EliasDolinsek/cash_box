import 'package:cash_box/app/injection.dart';
import 'package:cash_box/app/tags_bloc/bloc.dart';
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
      body: FilterWidget(
        onTagIdsChanged: (tagIds) {

        },
      ),
    );
  }
}

class FilterWidget extends StatelessWidget {
  final Function(List<String> tagIds) onTagIdsChanged;

  const FilterWidget({Key key, this.onTagIdsChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildTagsSelection();
  }

  Widget _buildTagsSelection(){
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text("Tags"),
        TagsSelectionWidget()
      ],
    );
  }
}
