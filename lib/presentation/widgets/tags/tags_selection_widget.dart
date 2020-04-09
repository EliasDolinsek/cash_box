import 'package:cash_box/app/injection.dart';
import 'package:cash_box/app/tags_bloc/bloc.dart';
import 'package:cash_box/domain/core/enteties/tags/tag.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/settings/dialogs/delete_dialog.dart';
import 'package:flutter/material.dart';

class TagsSelectionWidget extends StatefulWidget {
  final Function(List<String> update) onChange;
  final List<String> initialTagIds;

  const TagsSelectionWidget({Key key, this.initialTagIds, this.onChange})
      : super(key: key);

  @override
  _TagsSelectionWidgetState createState() => _TagsSelectionWidgetState();
}

class _TagsSelectionWidgetState extends State<TagsSelectionWidget> {
  List<String> tagIds;

  @override
  void initState() {
    super.initState();
    tagIds = widget.initialTagIds;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: sl<TagsBloc>().state,
      builder: (_, AsyncSnapshot<TagsState> snapshot) {
        if (snapshot.hasData) {
          final state = snapshot.data;
          if (state is TagsAvailableState) {
            return _buildLoaded(state.tags);
          } else if (state is TagsErrorState) {
            _loadTags();
            return _buildError(state.errorMessage);
          } else {
            _loadTags();
            return _buildLoading();
          }
        } else {
          return _buildLoading();
        }
      },
    );
  }

  Widget _buildLoaded(List<Tag> allTags) {
    final usableTags =
        allTags.where((element) => tagIds.contains(element.id)).toList();
    return Column(
      children: <Widget>[
        Builder(builder: (_) {
          if (usableTags.isNotEmpty) {
            return _buildTags(usableTags);
          } else {
            return _buildNoTags();
          }
        }),
        SizedBox(height: 8.0),
        MaterialButton(
          child: Text(AppLocalizations.translateOf(context, "btn_edit_tags")),
          onPressed: () => _showTagsSelectionPage(),
        ),
      ],
    );
  }

  Widget _buildNoTags() {
    return Text(AppLocalizations.translateOf(context, "no_tags"));
  }

  Widget _buildTags(List<Tag> tags) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: tags.map((tag) => _buildChipForTag(tag, () {})).toList(),
      ),
    );
  }

  Widget _buildError(String errorMessage) {
    return Center(child: Text(errorMessage));
  }

  Widget _buildLoading() {
    return Text(AppLocalizations.translateOf(context, "txt_loading"));
  }

  Widget _buildChipForTag(Tag tag, Function onDelete) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Chip(
        label: Text(tag.name),
        backgroundColor: tag.colorAsColor,
      ),
    );
  }

  void onDeleteRequest(Function onDelete) async {
    final result =
        await showDialog(context: context, builder: (_) => DeleteDialog());
    if (result != null && result) {
      onDelete();
    }
  }

  void _loadTags() {
    sl<TagsBloc>().dispatch(GetTagsEvent());
  }

  void _showTagsSelectionPage() async {
    Navigator.of(context).pushNamed("/tagsSelection", arguments: {
      "onChanged": (selectedTags) {
        print(selectedTags);
        setState(() => tagIds = selectedTags);
      },
      "initialSelectedTags": tagIds
    });
  }
}
