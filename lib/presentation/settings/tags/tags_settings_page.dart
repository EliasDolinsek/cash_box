import 'package:cash_box/app/injection.dart';
import 'package:cash_box/app/tags_bloc/bloc.dart';
import 'package:cash_box/domain/core/enteties/tags/tag.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/base/screen_type_layout.dart';
import 'package:cash_box/presentation/base/width_constrained_widget.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:cash_box/presentation/widgets/add_component_button.dart';
import 'package:cash_box/presentation/widgets/component_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TagsSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          AppLocalizations.translateOf(context, "tags_settings_page_title"),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ScreenTypeLayout(
          mobile: Align(
            alignment: Alignment.topCenter,
            child: WidthConstrainedWidget(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: _TagsSettingsPageContentWidget(),
              ),
            ),
          )
      ),
    );
  }
}

class _TagsSettingsPageContentWidget extends StatefulWidget {

  @override
  _TagsSettingsPageContentWidgetState createState() =>
      _TagsSettingsPageContentWidgetState();
}

class _TagsSettingsPageContentWidgetState
    extends State<_TagsSettingsPageContentWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          AddComponentButton(
            text: AppLocalizations.translateOf(context, "btn_add_tag"),
            onPressed: () => _addNewTag(context),
          ),
          BlocBuilder(
            bloc: sl<TagsBloc>(),
            builder: (context, state) {
              if (state is TagsAvailableState) {
                if (state.tags != null) {
                  return _buildTagsList(state.tags);
                } else {
                  return LoadingWidget();
                }
              } else {
                return LoadingWidget();
              }
            },
          )
        ],
      ),
    );
  }

  Widget _buildTagsList(List<Tag> tags) {
    return Column(
      children: tags
          .map((c) => TagListTile(
                tag: c,
                onTap: () {
                  Navigator.of(context).pushNamed("/tagsSettings/tagDetails", arguments: c);
                },
              ))
          .toList(),
    );
  }

  _addNewTag(BuildContext context) {
    final color = Tag.colorAsString(Theme.of(context).primaryColor);
    final tag = Tag.newTag(name: "", color: color);

    final event = AddTagEvent(tag);
    sl<TagsBloc>().dispatch(event);

    Navigator.of(context).pushNamed("/tagsSettings/tagDetails", arguments: tag);
  }
}
