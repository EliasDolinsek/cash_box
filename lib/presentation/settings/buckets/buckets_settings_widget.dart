import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/settings/settings_widget.dart';
import 'package:flutter/material.dart';

class BucketsSettingsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SettingsWidget(
      title: AppLocalizations.translateOf(context, "txt_bucket_settings"),
      content: _buildEditBucketsListTile(context),
    );
  }

  Widget _buildEditBucketsListTile(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.folder_open),
      ),
      title: Text(AppLocalizations.translateOf(context, "txt_buckets")),
      subtitle: Text(
          AppLocalizations.translateOf(context, "txt_bucket_settings_hint")),
      trailing: MaterialButton(
        onPressed: () {},
        child: Text(
          AppLocalizations.translateOf(context, "btn_more"),
        ),
      ),
    );
  }
}
