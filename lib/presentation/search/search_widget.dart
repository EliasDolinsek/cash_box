import 'package:cash_box/app/injection.dart';
import 'package:cash_box/app/search_bloc/bloc.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/search/receipts_overview_widget.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:cash_box/presentation/widgets/responsive_widget.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  String searchText;
  List<String> tagIds;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ResponsiveCardWidget(
        child: Column(
          children: <Widget>[
            _buildSearchBar(),
            SizedBox(height: 8.0),
            _buildSearchResult(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Column(
      children: <Widget>[_buildSearchTextField(), _buildTagsFilter()],
    );
  }

  Widget _buildSearchTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: AppLocalizations.translateOf(context, "txt_search"),
        ),
        onChanged: (value) => searchText = value,
        onSubmitted: (_) => _search(),
      ),
    );
  }

  Widget _buildTagsFilter() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[],
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
            return _buildLoaded(data.receipts);
          } else if (data is LoadingSearchState) {
            return _buildLoading();
          } else {
            return _buildEnterSearch();
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
      return ReceiptsOverviewWidget(receipts: receipts);
    } else {
      return _buildEnterSearch();
    }
  }

  Widget _buildEnterSearch() {
    return Center(
      child: Text(
        AppLocalizations.translateOf(context, "txt_search"),
      ),
    );
  }

  void _search() {
    final event = ReceiptsSearchEvent(text: searchText, tagIds: tagIds);
    sl<SearchBloc>().dispatch(event);
  }
}
