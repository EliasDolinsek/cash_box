import 'package:cash_box/app/contacts_bloc/bloc.dart';
import 'package:cash_box/app/injection.dart';
import 'package:cash_box/domain/core/enteties/contacts/contact.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/base/screen_type_layout.dart';
import 'package:cash_box/presentation/base/width_constrained_widget.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:cash_box/presentation/widgets/add_component_button.dart';
import 'package:cash_box/presentation/widgets/component_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: ScreenTypeLayout(
          mobile: Align(
        alignment: Alignment.topCenter,
        child: WidthConstrainedWidget(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: _ContactSettingsPageContentWidget(),
          ),
        ),
      )),
    );
  }
}

class _ContactSettingsPageContentWidget extends StatefulWidget {
  @override
  _ContactSettingsPageContentWidgetState createState() =>
      _ContactSettingsPageContentWidgetState();
}

class _ContactSettingsPageContentWidgetState
    extends State<_ContactSettingsPageContentWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          AddComponentButton(
            text: AppLocalizations.translateOf(context, "btn_add_bucket"),
            onPressed: () => _addNewContact(context),
          ),
          BlocBuilder(
            bloc: sl<ContactsBloc>(),
            builder: (context, state) {
              if (state is ContactsAvailableState) {
                if (state.contacts != null) {
                  return _buildContactsList(state.contacts);
                } else {
                  return LoadingWidget();
                }
              } else {
                return LoadingWidget();
              }
            },
          )
        ],
      ),
    );
  }

  Widget _buildContactsList(List<Contact> contacts) {
    return Column(
      children: contacts
          .map((c) => ContactListItem(
                c,
                onTap: () {
                  Navigator.of(context).pushNamed(
                    "/contactsSettings/contactDetails",
                    arguments: c,
                  );
                },
              ))
          .toList(),
    );
  }

  void _addNewContact(BuildContext context) {
    final text = AppLocalizations.translateOf(context, "txt_new_contact");
    final contact = Contact.newContact(name: text, fields: []);

    final event = AddContactEvent(contact);
    sl<ContactsBloc>().dispatch(event);

    Navigator.of(context)
        .pushNamed("/contactsSettings/contactDetails", arguments: contact);
  }
}
