import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/settings/settings_widget.dart';
import 'package:flutter/material.dart';

class TagsSettingsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SettingsWidget(
      title: AppLocalizations.translateOf(
          context, "tags_settings_widget_tags"),
      content: _buildEditTagsListTile(context),
    );
  }

  Widget _buildEditTagsListTile(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.bookmark),
      ),
      title: Text(localizations.translate("tags_settings_widget_edit_tags")),
      subtitle: Text(localizations.translate("tags_settings_widget_edit_tags_hint")),
      trailing: MaterialButton(
        child: Text(AppLocalizations.translateOf(context, "btn_more")),
        onPressed: () {
          Navigator.of(context).pushNamed("/tagsSettings");
        },
      ),
    );
  }
}
