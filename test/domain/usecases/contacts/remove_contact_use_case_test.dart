import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:cash_box/domain/usecases/contacts/remove_contact_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mock_contacts_repository.dart';

void main(){

  final repository = MockContactsRepository();
  final useCase = RemoveContactUseCase(repository);

  test("should call the repository to remove the contact", () async {
    when(repository.removeContact(any)).thenAnswer((_) async => Right(EmptyData()));

    final testID = "abc-123";
    final params = RemoveContactUseCaseParams(testID);
    final result = await useCase(params);

    expect(result, Right(EmptyData()));
    verify(repository.removeContact(testID));
  });
}