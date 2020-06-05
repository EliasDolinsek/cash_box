import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/settings/settings_list_tile.dart';
import 'package:cash_box/presentation/settings/settings_widget.dart';
import 'package:flutter/material.dart';

class TagsSettingsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return SettingsWidget(
      title: AppLocalizations.translateOf(context, "tags_settings_widget_tags"),
      content: SettingsListTile(
        title: localizations.translate("tags_settings_widget_edit_tags"),
        subtitle: localizations.translate("tags_settings_widget_edit_tags_hint"),
        icon: Icons.bookmark,
        onTap: () {
          Navigator.of(context).pushNamed("/tagsSettings");
        },
      ),
    );
  }
}
