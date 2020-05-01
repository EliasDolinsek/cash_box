import 'package:cash_box/app/contacts_bloc/bloc.dart';
import 'package:cash_box/app/injection.dart';
import 'package:cash_box/domain/core/enteties/contacts/contact.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:cash_box/presentation/widgets/responsive_widget.dart';
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
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => _addNewContact(context),
          );
        },
      ),
      body: StreamBuilder(
        stream: contactsBloc.state,
        builder: (context, AsyncSnapshot<ContactsState> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            if (data is ContactsAvailableState) {
              return ContactsAvailableSettingsWidget(data.contacts);
            } else if (data is ContactsErrorState) {
              contactsBloc.dispatch(GetContactsEvent());
              return Text("ERROR");
            } else {
              contactsBloc.dispatch(GetContactsEvent());
              return LoadingWidget();
            }
          } else {
            return LoadingWidget();
          }
        },
      ),
    );
  }

  void _addNewContact(BuildContext context) {
    final text = AppLocalizations.translateOf(context, "txt_new_contact");
    final contact = Contact.newContact(name: text, fields: []);

    final event = AddContactEvent(contact);
    sl<ContactsBloc>().dispatch(event);
  }
}

class ContactsAvailableSettingsWidget extends StatefulWidget {
  final List<Contact> contacts;

  const ContactsAvailableSettingsWidget(this.contacts, {Key key})
      : super(key: key);

  @override
  _ContactsAvailableSettingsWidgetState createState() =>
      _ContactsAvailableSettingsWidgetState();
}

class _ContactsAvailableSettingsWidgetState
    extends State<ContactsAvailableSettingsWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.contacts.isEmpty) return _buildNoContacts();
    return ResponsiveCardWidget(
      child: _buildLoaded(),
    );
  }

  Widget _buildNoContacts() {
    return Center(
      child: Text(
        AppLocalizations.translateOf(context, "no_contacts"),
      ),
    );
  }

  Widget _buildLoaded() {
    final contacts = widget.contacts.reversed;
    return Column(
      children: contacts.map((c) => ContactListItem(c)).toList(),
    );
  }
}

class ContactListItem extends StatelessWidget {
  final Contact contact;

  const ContactListItem(this.contact, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_getContactNameText(context)),
      subtitle: Text(
        _contactFieldsInfoAsString(context),
      ),
      onTap: () {
        Navigator.of(context)
            .pushNamed("/contactsSettings/contactDetails", arguments: contact);
      },
    );
  }

  String _getContactNameText(BuildContext context) {
    if (contact?.name != null && contact.name.isEmpty) {
      return AppLocalizations.translateOf(context, "unnamed");
    } else {
      return contact.name;
    }
  }

  String _contactFieldsInfoAsString(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    if (contact.fields.isEmpty) {
      return localizations.translate("txt_no_fields");
    } else {
      return contact.fields.map((f) {
        if (f.description.trim().isEmpty) {
          return AppLocalizations.translateOf(context, "unnamed");
        } else {
          return f.description;
        }
      }).join(" · ");
    }
  }
}
