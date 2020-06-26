import 'package:cash_box/app/injection.dart';
import 'package:cash_box/app/receipts_bloc/bloc.dart';
import 'package:cash_box/app/search_bloc/bloc.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt_month.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/base/screen_type_layout.dart';
import 'package:cash_box/presentation/base/width_constrained_widget.dart';
import 'package:cash_box/presentation/search/receipts_overview_widget.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:cash_box/presentation/widgets/search_text_field.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  ReceiptType receiptType;
  String searchText = "";
  List<String> tagIds = [];

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SpacedScreenTypeLayout(
        mobile: WidthConstrainedWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildSearchBar(),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  top: 16.0,
                ),
                child: _buildFilterButton(),
              ),
              Expanded(child: _buildSearchResult()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16.0,
      ),
      child: SearchTextField(
        onSearch: (text) => _search(),
        onChanged: (value) => setState(() => searchText = value),
      ),
    );
  }

  Widget _buildFilterButton() {
    return MaterialButton(
      onPressed: () => Navigator.pushNamed(
        context,
        "/filterSelection",
        arguments: {
          "onChanged": (ReceiptType receiptType, List<String> tagIds) {
            this.receiptType = receiptType;
            this.tagIds = tagIds;
            _search();
          },
          "selectedTagIds": tagIds,
          "selectedReceiptType": receiptType,
        },
      ),
      child: Text(
        AppLocalizations.translateOf(context, "btn_apply_filters"),
      ),
    );
  }

  Widget _buildSearchResult() {
    final searchBloc = sl<SearchBloc>();
    return StreamBuilder(
      stream: searchBloc.state,
      builder: (_, AsyncSnapshot<SearchState> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          if (data is ReceiptsSearchAvailableState) {
            return SingleChildScrollView(child: _buildLoaded(data.receipts));
          } else if (data is LoadingSearchState) {
            return _buildLoading();
          } else {
            return _buildSearch();
          }
        } else {
          return _buildLoading();
        }
      },
    );
  }

  Widget _buildLoading() {
    return Center(child: LoadingWidget());
  }

  Widget _buildLoaded(List<Receipt> receipts) {
    if (receipts.isNotEmpty) {
      return Column(
        children: <Widget>[
          ReceiptsOverviewWidget(
            receipts: receipts,
            onTap: (receipt) => Navigator.pushNamed(
              context,
              "/editReceipt",
              arguments: receipt.id,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Text(AppLocalizations.translateOf(
                context, "txt_change_month_to_see_earlier_receipts")),
          )
        ],
      );
    } else {
      return _buildNoSearchResults();
    }
  }

  Widget _buildSearch() {
    return Center(
      child: Text(
        AppLocalizations.translateOf(context, "txt_search"),
      ),
    );
  }

  Widget _buildNoSearchResults() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text(
          AppLocalizations.translateOf(context, "txt_no_search_result"),
        ),
      ),
    );
  }

  void _search() async {
    final text = searchText.isNotEmpty ? searchText : null;
    final tags = tagIds.isNotEmpty ? tagIds : null;
    var month = DateTime.now();

    final receiptsState = await sl<ReceiptsBloc>().state.first;
    if(receiptsState is ReceiptsAvailableState){
      month = receiptsState.month;
    }

    final event = ReceiptsSearchEvent(
      month,
      text: text,
      tagIds: tags,
      receiptType: receiptType
    );

    sl<SearchBloc>().dispatch(event);
  }
}
