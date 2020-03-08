import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/usecases/contacts/get_contact_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/contact_fixtures.dart';
import 'mock_contacts_repository.dart';

void main(){

  final repository = MockContactsRepository();
  final useCase = GetContactUseCase(repository);

  test("should get a contact with a specific id", () async {
    when(repository.getContacts()).thenAnswer((_) async => Right(contactFixtures));

    final testID = "abc-123";
    final params = GetContactUseCaseParams(testID);
    final result = await useCase(params);

    expect(result, Right(contactFixtures.first));
    verify(repository.getContacts());
  });

  test("should return a ContactNotFoundFailure when the searched contact doesn't exist", () async {
    when(repository.getContacts()).thenAnswer((_) async => Right(contactFixtures));

    final testID = "not_found";
    final params = GetContactUseCaseParams(testID);
    final result = await useCase(params);

    expect(result, Left(ContactNotFoundFailure()));
    verify(repository.getContacts());
  });
}