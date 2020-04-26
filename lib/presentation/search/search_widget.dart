import 'package:cash_box/app/injection.dart';
import 'package:cash_box/app/search_bloc/bloc.dart';
import 'package:cash_box/app/tags_bloc/bloc.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/domain/core/enteties/tags/tag.dart';
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
              suffixIcon: MaterialButton(
                onPressed: () => Navigator.pushNamed(context, "/filterSelection", arguments: (ReceiptType receiptType, List<String> tagIds){
                  tagIds = tagIds;
                  _search();
                }),
                child: Text(
                  AppLocalizations.translateOf(context, "btn_filter"),
                ),
              ),
            ),
            onChanged: (value) {
              setState(() => searchText = value);
            },
            onSubmitted: (_) => _search(),
          ),
        ),
      ),
    );
  }

  Widget _buildTagsFilter() {
    return StreamBuilder<TagsState>(
      stream: sl<TagsBloc>().state,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          if (data is TagsAvailableState) {
            return _buildTagsList(data.tags);
          } else if (data is TagsErrorState) {
            return Text(
              AppLocalizations.translateOf(context, "txt_could_not_load_tags"),
            );
          } else {
            _loadTags();
            return _buildLoadingText();
          }
        } else {
          return _buildLoadingText();
        }
      },
    );
  }

  void _loadTags() {
    sl<TagsBloc>().dispatch(GetTagsEvent());
  }

  Widget _buildLoadingText() {
    return Text(AppLocalizations.translateOf(context, "txt_loading"));
  }

  Widget _buildTagsList(List<Tag> tags) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: tags.map((e) {
          return Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: FilterChip(
              label: Text(e.name),
              avatar: CircleAvatar(
                backgroundColor: e.colorAsColor,
              ),
              selected: tagIds.contains(e.id),
              selectedColor: Colors.grey.withOpacity(0.3),
              onSelected: (value) {
                setState(() {
                  if (tagIds.contains(e.id)) {
                    tagIds.remove(e.id);
                  } else {
                    tagIds.add(e.id);
                  }
                });

                _search();
              },
            ),
          );
        }).toList(),
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

      final event = ReceiptsSearchEvent(text: text, tagIds: tags);
      sl<SearchBloc>().dispatch(event);
    }
  }

  bool _isSearchTextInputValid() => searchText.trim().isNotEmpty;
}
