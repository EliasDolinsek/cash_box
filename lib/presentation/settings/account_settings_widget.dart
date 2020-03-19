import 'package:cash_box/core/platform/input_converter.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/settings/name_email_settings_widget.dart';
import 'package:cash_box/presentation/settings/password_settings_widget.dart';
import 'package:flutter/material.dart';

class AccountSettingsWidget extends StatefulWidget {
  @override
  _AccountSettingsWidgetState createState() => _AccountSettingsWidgetState();
}

class _AccountSettingsWidgetState extends State<AccountSettingsWidget> {

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(AppLocalizations.translateOf(context, "account_settings_widget_account"),
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
            SizedBox(height: 16.0),
            NameEmailSettingsWidget(),
            SizedBox(height: 16.0),
            PasswordSettingsWidget(),
            SizedBox(height: 16.0,),
            _buildSubscriptionTitle(),
            SizedBox(height: 16.0),
            _buildDataStorageLocationTile(),
            SizedBox(height: 16.0),
            _buildUpdateButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionTitle() {
    return ListTile(
      title: Text("Subscription"),
      subtitle: Text("Business Pro"),
      leading: CircleAvatar(
        child: Icon(Icons.payment),
      ),
      trailing: MaterialButton(
        onPressed: () {},
        child: Text("MORE"),
      ),
    );
  }

  Widget _buildDataStorageLocationTile() {
    return ListTile(
      title: Text("Data storage lcoation"),
      subtitle: Text("Location where all app data get saved"),
      leading: CircleAvatar(
        child: Icon(Icons.storage),
      ),
      trailing: MaterialButton(
        onPressed: () {},
        child: Text("MORE"),
      ),
    );
  }

  Widget _buildUpdateButton() {
    return MaterialButton(
      child: Text("UPDATE"),
      onPressed: (){},
    );
  }

}
