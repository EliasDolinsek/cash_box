import 'package:cash_box/app/injection.dart';
import 'package:cash_box/app/tags_bloc/bloc.dart';
import 'package:cash_box/domain/core/enteties/tags/tag.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/settings/dialogs/delete_dialog.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:cash_box/presentation/widgets/component_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocBuilder(
      bloc: sl<TagsBloc>(),
      builder: (context, state) {
        if(state is TagsAvailableState){
          if(state.tags != null){
            return _buildLoaded(state.tags);
          } else {
            return LoadingWidget();
          }
        } else {
          return LoadingWidget();
        }
      },
    );
  }

  Widget _buildLoaded(List<Tag> allTags) {
    final usableTags =
        allTags.where((element) => tagIds.contains(element.id)).toList();

    return Builder(builder: (_) {
      if (usableTags.isNotEmpty) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTags(usableTags),
            _buildTrailingButton(),
          ],
        );
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(AppLocalizations.translateOf(context, "txt_no_tags_selected")),
            _buildTrailingButton(),
          ],
        );
      }
    });
  }

  Widget _buildTrailingButton(){
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: IconButton(
        icon: Icon(Icons.edit),
        onPressed: () => _showTagsSelectionPage(),
      ),
    );
  }

  Widget _buildTags(List<Tag> tags) {
    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: tags.map((tag) => _buildChipForTag(tag, () {})).toList(),
      ),
    );
  }

  Widget _buildChipForTag(Tag tag, Function onDelete) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: TagListTile(tag: tag),
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
