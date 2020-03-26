import 'package:cash_box/app/contacts_bloc/bloc.dart';
import 'package:cash_box/app/injection.dart';
import 'package:cash_box/app/tags_bloc/bloc.dart';
import 'package:cash_box/core/platform/entetie_converter.dart';
import 'package:cash_box/domain/core/enteties/contacts/contact.dart';
import 'package:cash_box/domain/core/enteties/tags/tag.dart';
import 'package:cash_box/domain/core/repositories/tags_repository.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/settings/dialogs/delete_dialog.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class TagsSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tagsBloc = sl<TagsBloc>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          AppLocalizations.translateOf(context, "tags_settings_page_title"),
          style: TextStyle(color: Colors.black),
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => _addNewTag(context),
          );
        },
      ),
      body: StreamBuilder(
        stream: tagsBloc.state,
        builder: (context, AsyncSnapshot<TagsState> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            if (data is TagsAvailableState) {
              return TagsAvailableSettingsWidget(data.tags);
            } else if (data is TagsErrorState) {
              tagsBloc.dispatch(GetTagsEvent());
              return Text("ERROR");
            } else {
              tagsBloc.dispatch(GetTagsEvent());
              return LoadingWidget();
            }
          } else {
            return LoadingWidget();
          }
        },
      ),
    );
  }

  void _addNewTag(BuildContext context) {
    final text = AppLocalizations.translateOf(context, "txt_new_tag");
    final color = Tag.colorAsString(Theme.of(context).primaryColor);
    final tag = Tag.newTag(name: text, color: color);

    final event = AddTagEvent(tag);
    sl<TagsBloc>().dispatch(event);

    _showAddingNewTagSnackbar(context);
  }

  void _showAddingNewTagSnackbar(BuildContext context) {
    final text = AppLocalizations.translateOf(context, "txt_adding_new_tag");
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}

class TagsAvailableSettingsWidget extends StatefulWidget {
  final List<Tag> tags;

  const TagsAvailableSettingsWidget(this.tags, {Key key}) : super(key: key);

  @override
  _TagsAvailableSettingsWidgetState createState() => _TagsAvailableSettingsWidgetState();
}

class _TagsAvailableSettingsWidgetState extends State<TagsAvailableSettingsWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.tags.isEmpty) return _buildNoTags();
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Container(
            constraints: BoxConstraints(maxWidth: 800),
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 1,
                    child: _buildLoaded(),
                  ),
                ),
              ),
            ),
          );
        } else {
          return SingleChildScrollView(child: _buildLoaded());
        }
      },
    );
  }

  Widget _buildNoTags() {
    return Center(
      child: Text(
        AppLocalizations.translateOf(context, "no_tags"),
      ),
    );
  }

  Widget _buildLoaded() {
    final contacts = widget.tags.reversed;
    return Column(
      children: contacts.map((c) => TagListItem(c)).toList(),
    );
  }
}

class TagListItem extends StatelessWidget {
  final Tag tag;

  const TagListItem(this.tag, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: tag.colorAsColor,
      ),
      title: Text(tag.name),
      onTap: (){
        Navigator.of(context).pushNamed("/tagsSettings/tagDetails", arguments: tag);
      },
    );
  }
}