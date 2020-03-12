import 'package:cash_box/domain/account/usecases/update_account_use_case.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/account_fixtures.dart';
import 'mocks.dart';

void main(){
  MockAccountsRepository repository;
  UpdateAccountUseCase useCase;

  setUp(() {
    repository = MockAccountsRepository();
    useCase = UpdateAccountUseCase(repository);
  });

  test("should call the repository to get an account", () async {
    final testID = "user-id-01";
    final testUpdatedAccount = accountFixtures.first;

    when(repository.updateAccount(any, any)).thenAnswer((realInvocation) async => Right(EmptyData()));

    final params = UpdateAccountUseCaseParams(testID, testUpdatedAccount);
    final result = await useCase(params);

    expect(result, Right(EmptyData()));
    verify(repository.updateAccount(testID, testUpdatedAccount));
  });
}