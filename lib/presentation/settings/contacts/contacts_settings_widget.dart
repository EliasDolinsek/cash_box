import 'package:cash_box/localizations/app_localizations.dart';
import 'package:flutter/material.dart';

class ContactsSettingsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppLocalizations.translateOf(
                  context, "contacts_settings_widget_categories"),
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 16.0),
            _buildEditCategoryListTile(context)
          ],
        ),
      ),
    );
  }

  Widget _buildEditCategoryListTile(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.category),
      ),
      title: Text(localizations.translate("contacts_settings_widget_edit_categories")),
      subtitle: Text(localizations.translate("contacts_settings_widget_edit_categories_hint")),
      trailing: MaterialButton(
        child: Text(AppLocalizations.translateOf(context, "btn_more")),
        onPressed: () {},
      ),
    );
  }
}
