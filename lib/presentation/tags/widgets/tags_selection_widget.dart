import 'package:cash_box/app/injection.dart';
import 'package:cash_box/app/tags_bloc/bloc.dart';
import 'package:cash_box/domain/core/enteties/tags/tag.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/settings/dialogs/delete_dialog.dart';
import 'package:cash_box/presentation/static_widgets/loading_text_widget.dart';
import 'package:flutter/material.dart';

class TagsSelectionBarWidget extends StatefulWidget {
  final Function(List<String> update) onChange;
  final List<String> initialTagIds;

  const TagsSelectionBarWidget({Key key, this.initialTagIds = const[], this.onChange})
      : super(key: key);

  @override
  _TagsSelectionBarWidgetState createState() => _TagsSelectionBarWidgetState();
}

class _TagsSelectionBarWidgetState extends State<TagsSelectionBarWidget> {
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
            return LoadingTextWidget();
          }
        } else {
          return LoadingTextWidget();
        }
      },
    );
  }

  Widget _buildLoaded(List<Tag> allTags) {
    final usableTags =
        allTags.where((element) => tagIds.contains(element.id)).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Builder(builder: (_) {
          if (usableTags.isNotEmpty) {
            return _buildTags(usableTags);
          } else {
            return Container();
          }
        }),
        MaterialButton(
          child: Text(AppLocalizations.translateOf(context, "btn_edit_tags")),
          onPressed: () => _showTagsSelectionPage(),
        ),
      ],
    );
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
        setState(() => tagIds = selectedTags);
        widget.onChange(tagIds);
      },
      "initialSelectedTags": tagIds
    });
  }
}
