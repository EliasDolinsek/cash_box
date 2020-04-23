import 'package:cash_box/app/accounts_bloc/bloc.dart';
import 'package:cash_box/app/injection.dart';
import 'package:cash_box/core/platform/config.dart';
import 'package:cash_box/core/platform/entetie_converter.dart';
import 'package:cash_box/core/usecases/use_case.dart';
import 'package:cash_box/domain/account/enteties/account.dart';
import 'package:cash_box/domain/account/usecases/get_user_id_use_case.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/settings/dialogs/data_storage_location_selection_dialog.dart';
import 'package:cash_box/presentation/settings/name_email_settings_widget.dart';
import 'package:cash_box/presentation/settings/password_settings_widget.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:cash_box/presentation/widgets/default_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AccountSettingsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppLocalizations.translateOf(
                  context, "account_settings_widget_account"),
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 16.0),
            NameEmailSettingsWidget(),
            SizedBox(height: 16.0),
            PasswordSettingsWidget(),
            SizedBox(
              height: 16.0,
            ),
            SubscriptionTile(),
            _buildDataStorageLocationTile()
          ],
        ),
      ),
    );
  }

  Widget _buildDataStorageLocationTile(){
    if(kIsWeb){
      return Container();
    } else {
      return Column(
        children: <Widget>[
          SizedBox(height: 16.0),
          DataStorageLocationTile()
        ],
      );
    }
  }
}

class SubscriptionTile extends StatefulWidget {
  @override
  _SubscriptionTileState createState() => _SubscriptionTileState();
}

class _SubscriptionTileState extends State<SubscriptionTile> {
  @override
  Widget build(BuildContext context) {
    final accountsBloc = sl<AccountsBloc>();
    return StreamBuilder(
      stream: accountsBloc.state,
      builder: (_, AsyncSnapshot<AccountsState> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          if (data is AccountAvailableState) {
            return _buildLoaded(data.account);
          } else {
            _callGetAccountEvent(accountsBloc);
            return LoadingWidget();
          }
        } else {
          return LoadingWidget();
        }
      },
    );
  }

  void _callGetAccountEvent(AccountsBloc accountsBloc) {
    _getUserID().then((value) {
      if (value != null) {
        accountsBloc.dispatch(GetAccountEvent(value));
      }
    });
  }

  Future<String> _getUserID() async {
    final useCase = sl<GetUserIdUserCase>();
    final result = await useCase(NoParams());
    return result.fold((l) => null, (userID) => userID);
  }

  Widget _buildLoaded(Account account) {
    String subscriptionAsString = getSubscriptionTypeAsString(
        account.subscriptionInfo.subscriptionType,
        AppLocalizations.of(context));
    return ListTile(
      title: Text(
        AppLocalizations.translateOf(
            context, "account_settings_widget_subscription"),
      ),
      subtitle: Text(subscriptionAsString),
      leading: CircleAvatar(
        child: Icon(Icons.payment),
      ),
      trailing: MaterialButton(
        onPressed: () {},
        child: Text(
          AppLocalizations.translateOf(context, "btn_more"),
        ),
      ),
    );
  }
}

class DataStorageLocationTile extends StatefulWidget {
  @override
  _DataStorageLocationTileState createState() =>
      _DataStorageLocationTileState();
}

class _DataStorageLocationTileState extends State<DataStorageLocationTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(AppLocalizations.translateOf(
          context, "account_settings_widget_data_storage_location")),
      subtitle: FutureBuilder(
          future: _getDataStorageLocationAsString(context),
          builder: (_, AsyncSnapshot<String> data) {
            if (data.hasData) {
              return Text(data.data);
            } else {
              final text = AppLocalizations.translateOf(
                  context, "account_settings_widget_loading");
              return Text(text);
            }
          }),
      leading: CircleAvatar(
        child: Icon(Icons.storage),
      ),
      trailing: MaterialButton(
        onPressed: _showDataStorageLocationSelectionDialog,
        child: Text(
          AppLocalizations.translateOf(context, "btn_more"),
        ),
      ),
    );
  }

  Future<String> _getDataStorageLocationAsString(BuildContext context) async {
    final dataStorageLocation = await sl<Config>().dataStorageLocation;
    return getDataStorageLocationAsString(
        dataStorageLocation, AppLocalizations.of(context));
  }

  void _showDataStorageLocationSelectionDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return DataStorageLocationSelectionDialog(
          onChanged: () => setState((){}),
        );
      },
    );
  }
}
