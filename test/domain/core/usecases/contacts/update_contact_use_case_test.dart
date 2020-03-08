import 'package:cash_box/domain/core/enteties/contact.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:cash_box/domain/core/usecases/contacts/update_contact_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/field_fixtures.dart';
import 'mock_contacts_repository.dart';

void main(){
  final repository = MockContactsRepository();
  final useCase = UpdateContactUseCase(repository);
  
  test("should call the repository to update an contact", () async {
    when(repository.updateContact(any, any)).thenAnswer((_) async => Right(EmptyData()));

    final testID = "abc-123";
    final testFields = fieldFixtures..removeLast();

    final params = UpdateContactUseCaseParams(testID, testFields);
    final result = await useCase(params);

    expect(result, Right(EmptyData()));
    verify(repository.updateContact(testID, Contact(testID, fields: testFields)));
  });
}