import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:cash_box/domain/core/usecases/contacts/add_contact_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/contact_fixtures.dart';
import 'mock_contacts_repository.dart';

void main(){

  MockContactsRepository repository;
  AddContactUseCase useCase;

  setUp((){
    repository = MockContactsRepository();
    useCase = AddContactUseCase(repository);
  });

  test("should call the repository to add a new contact", () async {
    when(repository.addContact(any)).thenAnswer((_) async => Right(EmptyData()));

    final testContact = contactFixtures.first;
    final params = AddContactParams(testContact);
    final result = await useCase(params);

    expect(result, Right(EmptyData()));
    verify(repository.addContact(testContact));
  });
}