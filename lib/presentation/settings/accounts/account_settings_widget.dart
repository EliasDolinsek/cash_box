import 'package:cash_box/app/accounts_bloc/bloc.dart';
import 'package:cash_box/app/auth_bloc/bloc.dart';
import 'package:cash_box/app/injection.dart';
import 'package:cash_box/core/platform/config.dart';
import 'package:cash_box/core/platform/entetie_converter.dart';
import 'package:cash_box/domain/account/usecases/auth/sign_out_use_case.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:cash_box/domain/account/enteties/account.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/auth/auth_toolbox.dart';
import 'package:cash_box/presentation/settings/dialogs/data_storage_location_selection_dialog.dart';
import 'package:cash_box/presentation/settings/name_email_settings_widget.dart';
import 'package:cash_box/presentation/settings/password_settings_widget.dart';
import 'package:cash_box/presentation/settings/settings_list_tile.dart';
import 'package:cash_box/presentation/settings/settings_widget.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountSettingsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SettingsWidget(
      title: AppLocalizations.translateOf(
          context, "account_settings_widget_account"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          NameEmailSettingsWidget(),
          SizedBox(height: 16.0),
          PasswordSettingsWidget(),
          SizedBox(height: 16.0),
          SubscriptionTile(),
          _buildDataStorageLocationTile(),
          _buildSignOutTile(context)
        ],
      ),
    );
  }

  Widget _buildDataStorageLocationTile() {
    if (kIsWeb) {
      return Container();
    } else {
      return Column(
        children: <Widget>[SizedBox(height: 16.0), DataStorageLocationTile()],
      );
    }
  }

  Widget _buildSignOutTile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: SettingsListTile(
        title: AppLocalizations.translateOf(context, "navigation_sign_out"),
        icon: Icons.exit_to_app,
        onTap: () async {
          showSigningOutSnackbar(context);
          await signOut();
        },
      ),
    );
  }
}

class SubscriptionTile extends StatefulWidget {
  @override
  _SubscriptionTileState createState() => _SubscriptionTileState();
}

class _SubscriptionTileState extends State<SubscriptionTile> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: sl<AccountsBloc>(),
      builder: (context, state) {
        if (state is AccountAvailableState) {
          final account = state.account;
          if (account != null) {
            return _buildLoaded(account);
          } else {
            return LoadingWidget();
          }
        } else {
          return LoadingWidget();
        }
      },
    );
  }

  Widget _buildLoaded(Account account) {
    String subscriptionAsString = getSubscriptionTypeAsString(
        account.subscriptionInfo.subscriptionType,
        AppLocalizations.of(context));

    return SettingsListTile(
      title: AppLocalizations.translateOf(
          context, "account_settings_widget_subscription"),
      subtitle: subscriptionAsString,
      icon: Icons.payment,
      onTap: null,
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
    return FutureBuilder(
      future: _getDataStorageLocationAsString(context),
      builder: (_, AsyncSnapshot<String> data) {
        if (data.hasData) {
          return SettingsListTile(
            title: AppLocalizations.translateOf(
                context, "account_settings_widget_data_storage_location"),
            subtitle: data.data,
            icon: Icons.storage,
            onTap: _showDataStorageLocationSelectionDialog,
          );
        } else {
          final text = AppLocalizations.translateOf(
              context, "account_settings_widget_loading");
          return Text(text);
        }
      },
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
          onChanged: () => setState(() {}),
        );
      },
    );
  }
}
