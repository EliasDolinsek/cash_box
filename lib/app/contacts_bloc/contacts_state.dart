import 'package:equatable/equatable.dart';

abstract class ContactsState extends Equatable {
  const ContactsState();
}

class InitialContactsState extends ContactsState {
  @override
  List<Object> get props => [];
}
