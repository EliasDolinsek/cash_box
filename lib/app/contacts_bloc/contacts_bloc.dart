import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:cash_box/domain/core/usecases/contacts/add_contact_use_case.dart';
import 'package:cash_box/domain/core/usecases/contacts/get_contact_use_case.dart';
import 'package:cash_box/domain/core/usecases/contacts/get_contacts_use_case.dart';
import 'package:cash_box/domain/core/usecases/contacts/remove_contact_use_case.dart';
import 'package:cash_box/domain/core/usecases/contacts/update_contact_use_case.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final AddContactUseCase addContactUseCase;
  final GetContactUseCase getContactUseCase;
  final GetContactsUseCase getContactsUseCase;
  final RemoveContactUseCase removeContactUseCase;
  final UpdateContactUseCase updateContactUseCase;

  ContactsBloc(
      {@required this.addContactUseCase,
      @required this.getContactUseCase,
      @required this.getContactsUseCase,
      @required this.removeContactUseCase,
      @required this.updateContactUseCase});

  @override
  ContactsState get initialState => InitialContactsState();

  @override
  Stream<ContactsState> mapEventToState(
    ContactsEvent event,
  ) async* {
    if (event is AddContactEvent) {
      final params = AddContactParams(event.contact);
      await addContactUseCase(params);
      dispatch(GetContactsEvent());
    } else if (event is GetContactsEvent) {
      yield await _getContacts();
    } else if (event is UpdateContactEvent) {
      final params = UpdateContactUseCaseParams(event.contactID,
          name: event.name, fields: event.fields);
      await updateContactUseCase(params);
      dispatch(GetContactsEvent());
    } else if (event is RemoveContactEvent) {
      final params = RemoveContactUseCaseParams(event.contactID);
      await removeContactUseCase(params);
      dispatch(GetContactsEvent());
    }
  }

  Future<ContactsState> _getContacts() async {
    final contactEither = await getContactsUseCase(NoParams());
    return contactEither.fold((l) => ContactsErrorState(l.toString()),
        (contacts) {
      return ContactsAvailableState(contacts);
    });
  }
}
