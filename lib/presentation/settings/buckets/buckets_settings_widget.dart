import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/settings/settings_list_tile.dart';
import 'package:cash_box/presentation/settings/settings_widget.dart';
import 'package:flutter/material.dart';

class BucketsSettingsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SettingsWidget(
      title: AppLocalizations.translateOf(context, "txt_bucket_settings"),
      content: SettingsListTile(
        title: AppLocalizations.translateOf(context, "txt_buckets"),
        subtitle:
        AppLocalizations.translateOf(context, "txt_bucket_settings_hint"),
        icon: Icons.label_outline,
        onTap: () => Navigator.of(context).pushNamed("/bucketSettings"),),
    );
  }
}
