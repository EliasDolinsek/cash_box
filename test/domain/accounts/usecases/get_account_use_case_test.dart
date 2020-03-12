import 'package:cash_box/domain/account/usecases/get_account_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/account_fixtures.dart';
import 'mocks.dart';

void main(){
  MockAccountsRepository repository;
  GetAccountUseCase useCase;

  setUp(() {
    repository = MockAccountsRepository();
    useCase = GetAccountUseCase(repository);
  });

  test("should call the repository to get an account", () async {
    final testID = "user-id-01";
    when(repository.getAccount(any)).thenAnswer((realInvocation) async => Right(accountFixtures.first));

    final params = GetAccountUseCaseParams(testID);
    final result = await useCase(params);

    expect(result, Right(accountFixtures.first));
    verify(repository.getAccount(testID));
  });
}