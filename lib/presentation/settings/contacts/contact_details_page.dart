import 'package:cash_box/domain/core/enteties/contacts/contact.dart';
import 'package:flutter/material.dart';

class ContactDetailsPage extends StatelessWidget {

  final Contact contact;

  const ContactDetailsPage(this.contact, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contact.name),
        backgroundColor: Colors.white,
      ),
    );
  }
}
