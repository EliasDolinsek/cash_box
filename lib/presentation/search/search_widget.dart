import 'package:cash_box/app/injection.dart';
import 'package:cash_box/app/search_bloc/bloc.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/search/receipts_overview_widget.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:cash_box/presentation/widgets/default_card.dart';
import 'package:cash_box/presentation/widgets/responsive_widget.dart';
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
    return ResponsiveCardWidget(
      child: Column(
        children: <Widget>[
          _buildSearchBar(),
          SizedBox(height: 8.0),
          Expanded(child: _buildSearchResult()),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return _buildSearchTextField();
  }

  Widget _buildSearchTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
      child: DefaultCard(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: AppLocalizations.translateOf(context, "txt_search"),
              suffixIcon: _buildFilterButton(),
            ),
            onChanged: (value) => setState(() => searchText = value),
            onSubmitted: (_) => _search(),
          ),
        ),
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
        AppLocalizations.translateOf(context, "btn_filter"),
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
      return ReceiptsOverviewWidget(
        receipts: receipts,
        onTap: (receipt) => Navigator.pushNamed(
          context,
          "/editReceipt",
          arguments: receipt.id,
        ),
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
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Text(
        AppLocalizations.translateOf(context, "txt_no_search_result"),
      ),
    );
  }

  void _search() {
    if (_isSearchTextInputValid() || tagIds.isNotEmpty) {
      final text = searchText.isNotEmpty ? searchText : null;
      final tags = tagIds.isNotEmpty ? tagIds : null;

      final event = ReceiptsSearchEvent(
          text: text, tagIds: tags, receiptType: receiptType);

      sl<SearchBloc>().dispatch(event);
    }
  }

  bool _isSearchTextInputValid() => searchText.trim().isNotEmpty;
}
