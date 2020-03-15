import 'package:cash_box/domain/core/enteties/contacts/contact.dart';
import 'package:cash_box/domain/core/enteties/fields/field.dart';
import 'package:equatable/equatable.dart';

abstract class ContactsEvent extends Equatable {}

class AddContactEvent extends ContactsEvent {
  final Contact contact;

  AddContactEvent(this.contact);

  @override
  List get props => [contact];
}

class GetContactEvent extends ContactsEvent {
  final String contactID;

  GetContactEvent(this.contactID);

  @override
  List get props => [contactID];
}

class GetContactsEvent extends ContactsEvent {}

class RemoveContactEvent extends ContactsEvent {

  final String contactID;

  RemoveContactEvent(this.contactID);

  @override
  List get props => [contactID];

}

class UpdateContactEvent extends ContactsEvent {

  final String contactID;
  final List<Field> fields;

  UpdateContactEvent(this.contactID, this.fields);
}