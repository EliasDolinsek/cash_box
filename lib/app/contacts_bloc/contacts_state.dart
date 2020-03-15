import 'package:cash_box/domain/core/enteties/contacts/contact.dart';
import 'package:equatable/equatable.dart';

abstract class ContactsState extends Equatable {}

class InitialContactsState extends ContactsState {
  @override
  List<Object> get props => [];
}

class ContactsAvailableState extends ContactsState {
  final List<Contact> contacts;

  ContactsAvailableState(this.contacts);

  @override
  List get props => [contacts];
}

class ContactsUnavailableState extends ContactsState {}

class ContactAvailableState extends ContactsState {

  final Contact contact;

  ContactAvailableState(this.contact);

  @override
  List get props => [contact];

}

class ContactsErrorState extends ContactsState {

  final String errorMessage;

  ContactsErrorState(this.errorMessage);

  @override
  List get props => [errorMessage];
}