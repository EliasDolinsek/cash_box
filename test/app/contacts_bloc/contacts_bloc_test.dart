import 'package:cash_box/app/contacts_bloc/bloc.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:cash_box/domain/core/enteties/contacts/contact.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:cash_box/domain/core/usecases/contacts/add_contact_use_case.dart';
import 'package:cash_box/domain/core/usecases/contacts/get_contact_use_case.dart';
import 'package:cash_box/domain/core/usecases/contacts/get_contacts_use_case.dart';
import 'package:cash_box/domain/core/usecases/contacts/remove_contact_use_case.dart';
import 'package:cash_box/domain/core/usecases/contacts/update_contact_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/contact_fixtures.dart';
import '../../fixtures/field_fixtures.dart';

class MockAddContactUseCase extends Mock implements AddContactUseCase {}

class MockGetContactUseCase extends Mock implements GetContactUseCase {}

class MockGetContactsUseCase extends Mock implements GetContactsUseCase {}

class MockRemoveContactUseCase extends Mock implements RemoveContactUseCase {}

class MockUpdateContactUseCase extends Mock implements UpdateContactUseCase {}

void main() {
  final MockAddContactUseCase addContactUseCase = MockAddContactUseCase();
  final MockGetContactUseCase getContactUseCase = MockGetContactUseCase();
  final MockGetContactsUseCase getContactsUseCase = MockGetContactsUseCase();
  final MockRemoveContactUseCase removeContactUseCase =
      MockRemoveContactUseCase();
  final MockUpdateContactUseCase updateContactUseCase =
      MockUpdateContactUseCase();

  ContactsBloc contactsBloc;

  setUp(() {
    contactsBloc = ContactsBloc(
        addContactUseCase: addContactUseCase,
        getContactUseCase: getContactUseCase,
        getContactsUseCase: getContactsUseCase,
        removeContactUseCase: removeContactUseCase,
        updateContactUseCase: updateContactUseCase);
  });

  test("AddContactEvent", () async {
    final contact = contactFixtures.first;
    final params = AddContactParams(contact);

    when(getContactsUseCase.call(any)).thenAnswer((_) async => Right(contactFixtures));
    when(addContactUseCase.call(params))
        .thenAnswer((_) async => Right(EmptyData()));

    final expected = [ContactsLoadingState(), ContactsAvailableState(contactFixtures)];

    expectLater(contactsBloc.state, emitsInOrder(expected));

    final event = AddContactEvent(contact);
    contactsBloc.dispatch(event);
  });

  test("GetContactEvent", () async {
    final contact = contactFixtures.first;
    final params = GetContactUseCaseParams(contact.id);
    when(getContactUseCase.call(params))
        .thenAnswer((_) async => Right(contact));

    final expected = [ContactsLoadingState(), ContactAvailableState(contact)];

    expectLater(contactsBloc.state, emitsInOrder(expected));

    final event = GetContactEvent(contact.id);
    contactsBloc.dispatch(event);
  });

  test("GetContactsEvent", () async {
    when(getContactsUseCase.call(NoParams()))
        .thenAnswer((_) async => Right(contactFixtures));

    final expected = [
      ContactsLoadingState(),
      ContactsAvailableState(contactFixtures)
    ];

    expectLater(contactsBloc.state, emitsInOrder(expected));

    final event = GetContactsEvent();
    contactsBloc.dispatch(event);
  });

  test("UpdateContactEvent", () async {
    final contact = contactFixtures.first;
    final update = Contact(contact.id, fields: fieldFixtures);

    when(getContactsUseCase.call(any)).thenAnswer((_) async => Right(contactFixtures));

    final params = UpdateContactUseCaseParams(update.id, update.fields);
    when(updateContactUseCase.call(params)).thenAnswer((_) async => Right(EmptyData()));

    final expected = [ContactsLoadingState(), ContactsAvailableState(contactFixtures)];
    expectLater(contactsBloc.state, emitsInOrder(expected));

    contactsBloc.dispatch(GetContactsEvent());
  });

  test("RemoveContactEvent", () async {
    final contact = contactFixtures.first;
    final params = RemoveContactUseCaseParams(contact.id);

    when(getContactsUseCase.call(any)).thenAnswer((_) async => Right(contactFixtures));
    when(removeContactUseCase.call(params))
        .thenAnswer((_) async => Right(EmptyData()));

    final expected = [ContactsLoadingState(), ContactsAvailableState(contactFixtures)];

    expectLater(contactsBloc.state, emitsInOrder(expected));

    final event = RemoveContactEvent(contact.id);
    contactsBloc.dispatch(event);
  });
}
