import 'package:cash_box/app/injection.dart';
import 'package:cash_box/app/tags_bloc/bloc.dart';
import 'package:cash_box/domain/core/enteties/tags/tag.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:cash_box/presentation/widgets/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TagsSelectionPage extends StatelessWidget {
  final Function(List<String> selectedTags) onChanged;
  final List<String> selectedTags;

  const TagsSelectionPage(
      {Key key, this.selectedTags = const [], this.onChanged})
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
      body: TagsSelectionWidget(
        initialSelectedTags: selectedTags,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildEditTagsButton(BuildContext context) {
    return MaterialButton(
      child: Text(AppLocalizations.translateOf(context, "btn_edit_tags")),
      onPressed: () => Navigator.of(context).pushNamed("/tagsSettings"),
    );
  }
}

class TagsSelectionWidget extends StatefulWidget {
  final Function(List<String> tagIds) onChanged;
  final List<String> initialSelectedTags;

  const TagsSelectionWidget(
      {Key key, this.initialSelectedTags = const[], this.onChanged})
      : super(key: key);

  @override
  _TagsSelectionWidgetState createState() => _TagsSelectionWidgetState();
}

class _TagsSelectionWidgetState extends State<TagsSelectionWidget> {
  List<String> selectedTags = [];

  @override
  void initState() {
    super.initState();
    selectedTags.addAll(widget.initialSelectedTags);
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

  Widget _buildLoaded(List<Tag> tags) {
    if (tags.isNotEmpty) {
      return ResponsiveCardWidget(
        child: SingleChildScrollView(child: _buildTagsList(tags)),
      );
    } else {
      return Center(
        child: Text(AppLocalizations.translateOf(context, "no_tags")),
      );
    }
  }

  Widget _buildTagsList(List<Tag> tags) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: tags.map((tag) => _buildTagListTile(tag)).toList(),
    );
  }

  Widget _buildTagListTile(Tag tag){
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      leading: CircleAvatar(backgroundColor: tag.colorAsColor),
      title: Text(tag.name),
      trailing: _buildTrailingForTag(tag),
      onTap: () => _onTap(tag),
    );
  }

  void _onTap(Tag tag) {
    setState(() {
      if (_isTagSelected(tag)) {
        selectedTags.remove(tag.id);
      } else {
        selectedTags.add(tag.id);
      }
    });

    widget.onChanged?.call(selectedTags);
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
