import 'package:cash_box/app/injection.dart';
import 'package:cash_box/app/tags_bloc/bloc.dart';
import 'package:cash_box/domain/core/enteties/tags/tag.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class TagsSelectionPage extends StatelessWidget {

  final Function(List<String> selectedTags) onChanged;
  final List<String> selectedTags;

  const TagsSelectionPage({Key key, this.selectedTags = const [], this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.translateOf(context, "txt_tags_selection"),
        ),
        actions: <Widget>[_buildEditTagsButton(context)],
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder(
        stream: sl<TagsBloc>().state,
        builder: (_, AsyncSnapshot<TagsState> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            if (data is TagsAvailableState) {
              return _buildLoaded(context, data.tags);
            } else if (data is TagsErrorState) {
              _loadTags();
              return ErrorWidget(data.errorMessage);
            } else {
              _loadTags();
              return LoadingWidget();
            }
          } else {
            return Center(child: LoadingWidget());
          }
        },
      ),
    );
  }

  Widget _buildLoaded(BuildContext context, List<Tag> tags) {
    if (tags.isNotEmpty) {
      return _TagsSelectionWidget(
        tags: tags,
        initialSelectedTags: selectedTags,
        onChanged: onChanged
      );
    } else {
      return Center(
        child: Text(AppLocalizations.translateOf(context, "no_tags")),
      );
    }
  }

  void _loadTags() {
    sl<TagsBloc>().dispatch(GetTagsEvent());
  }

  Widget _buildEditTagsButton(BuildContext context) {
    return MaterialButton(
      child: Text(AppLocalizations.translateOf(context, "btn_edit_tags")),
      onPressed: () => Navigator.of(context).pushNamed("/tagsSettings"),
    );
  }
}

class _TagsSelectionWidget extends StatefulWidget {

  final Function(List<String> tagIds) onChanged;
  final List<String> initialSelectedTags;
  final List<Tag> tags;

  const _TagsSelectionWidget(
      {Key key, @required this.tags, @required this.initialSelectedTags, this.onChanged})
      : super(key: key);

  @override
  _TagsSelectionWidgetState createState() => _TagsSelectionWidgetState();
}

class _TagsSelectionWidgetState extends State<_TagsSelectionWidget> {
  List<String> selectedTags = [];

  @override
  void initState() {
    super.initState();
    selectedTags.addAll(widget.initialSelectedTags);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.tags.length,
      itemBuilder: (_, index) {
        final tag = widget.tags[index];
        return ListTile(
          leading: CircleAvatar(backgroundColor: tag.colorAsColor),
          title: Text(tag.name),
          trailing: _buildTrailingForTag(tag),
          onTap: () => _onTap(tag),
        );
      },
      separatorBuilder: (_, __) => Divider(),
    );
  }

  void _onTap(Tag tag){
    setState(() {
      if(_isTagSelected(tag)){
        selectedTags.remove(tag.id);
      } else {
        selectedTags.add(tag.id);
      }
    });

    widget.onChanged(selectedTags);
  }

  Widget _buildTrailingForTag(Tag tag) {
    if (_isTagSelected(tag)) {
      return Icon(Icons.check);
    } else {
      return Container(
        width: 0,
        height: 0,
      );
    }
  }

  bool _isTagSelected(Tag tag) => selectedTags.contains(tag.id);
}
