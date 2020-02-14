import 'package:cash_box/domain/usecases/contacts/get_contacts_use_case.dart';
import 'package:cash_box/domain/usecases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/contact_fixtures.dart';
import 'mock_contacts_repository.dart';

void main(){

  final repository = MockContactsRepository();
  final useCase = GetContactsUseCase(repository);
  
  test("should call the repository to get all contacts", () async {
    when(repository.getContacts()).thenAnswer((_) async => Right(contactFixtures));
    
    final result = await useCase(NoParams());

    final resultList = result.getOrElse(() => throw Exception("Failure in result"));
    assert(listEquals(resultList, contactFixtures));
    verify(repository.getContacts());
  });
}