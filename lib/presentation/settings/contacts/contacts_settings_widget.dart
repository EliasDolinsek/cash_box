import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/settings/settings_widget.dart';
import 'package:flutter/material.dart';

import '../settings_list_tile.dart';

class ContactsSettingsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return SettingsWidget(
      title: AppLocalizations.translateOf(
          context, "contacts_settings_widget_categories"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SettingsListTile(
            title: localizations.translate("contacts_settings_widget_edit_contacts"),
            subtitle: localizations.translate("contacts_settings_widget_edit_contacts_hint"),
            icon: Icons.contacts,
            onTap: () {
              Navigator.of(context).pushNamed("/contactsSettings");
            },
          ),
          SizedBox(height: 16.0),
          SettingsListTile(
            title: localizations.translate("contacts_settings_widget_import_contacts"),
            subtitle: localizations.translate("contacts_settings_widget_import_contacts_hint"),
            icon: Icons.cloud_download,
            onTap: () {

            },
          ),
          SizedBox(height: 16.0),
          SettingsListTile(
            title: localizations.translate("contacts_settings_widget_export_contacts"),
            subtitle: localizations.translate("contacts_settings_widget_export_contacts_hint"),
            icon: Icons.cloud_upload,
            onTap: () {

            },
          ),
        ],
      ),
    );
  }
}
