import 'package:cash_box/app/contacts_bloc/bloc.dart';
import 'package:cash_box/app/injection.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:flutter/material.dart';

class ContactsSettingsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final contactsBloc = sl<ContactsBloc>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          AppLocalizations.translateOf(context, "contacts_settings_page_title"),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder(
        stream: contactsBloc.state,
      ),
    );
  }
}
