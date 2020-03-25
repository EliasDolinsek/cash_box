import 'package:cash_box/localizations/app_localizations.dart';
import 'package:flutter/material.dart';

class TagsSettingsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppLocalizations.translateOf(
                  context, "tags_settings_widget_tags"),
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 16.0),
            _buildEditTagsListTile(context),
          ],
        ),
      ),
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
