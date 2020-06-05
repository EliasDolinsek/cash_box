import 'package:cash_box/domain/core/enteties/contacts/contact.dart';
import 'package:equatable/equatable.dart';

abstract class ContactsState extends Equatable {}

class ContactsLoadingState extends ContactsState {
  @override
  List<Object> get props => [];
}

class ContactsAvailableState extends ContactsState {
  final List<Contact> contacts;

  ContactsAvailableState(this.contacts);

  @override
  List get props => [contacts];
}