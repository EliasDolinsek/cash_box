import 'package:cash_box/app/contacts_bloc/bloc.dart';
import 'package:cash_box/app/injection.dart';
import 'package:cash_box/core/platform/entetie_converter.dart';
import 'package:cash_box/domain/core/enteties/contacts/contact.dart';
import 'package:cash_box/domain/core/enteties/fields/field.dart';
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _openAddContactPage,
      ),
      body: StreamBuilder(
        stream: contactsBloc.state,
        builder: (context, AsyncSnapshot<ContactsState> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            if (data is ContactsAvailableState) {
              return ContactsSettingsWidget(data.contacts);
            } else if (data is ContactsErrorState) {
              contactsBloc.dispatch(GetContactsEvent());
              return Text("ERROR");
            } else {
              contactsBloc.dispatch(GetContactsEvent());
              return _buildLoading();
            }
          } else {
            return _buildLoading();
          }
        },
      ),
    );
  }

  void _openAddContactPage() {
    throw UnimplementedError();
  }

  Widget _buildLoading() {
    return Expanded(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class ContactsSettingsWidget extends StatefulWidget {
  final List<Contact> contacts;

  const ContactsSettingsWidget(this.contacts, {Key key}) : super(key: key);

  @override
  _ContactsSettingsWidgetState createState() => _ContactsSettingsWidgetState();
}

class _ContactsSettingsWidgetState extends State<ContactsSettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.contacts.length,
      itemBuilder: (context, index) {
        return ContactListItem(widget.contacts[index]);
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }
}

class ContactListItem extends StatelessWidget {
  final Contact contact;

  const ContactListItem(this.contact, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(contact.name),
      subtitle: Text(
        _contactFieldsInfoAsString(context),
      ),
    );
  }

  String _contactFieldsInfoAsString(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    if (contact.fields.isEmpty) {
      return localizations.translate("contact_settings_page_no_fields");
    } else {
      return contact.fields.map((f) {
        return getFieldTypeAsString(f.type, localizations);
      }).join(" · ");
    }
  }
}
