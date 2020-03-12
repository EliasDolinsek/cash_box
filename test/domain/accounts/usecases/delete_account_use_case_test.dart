import 'package:cash_box/domain/account/usecases/delete_account_use_case.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mocks.dart';

void main(){
  MockAccountsRepository repository;
  DeleteAccountUseCase useCase;

  setUp(() {
    repository = MockAccountsRepository();
    useCase = DeleteAccountUseCase(repository);
  });

  test("should call the repository to delete an account", () async {
    String userID = "user-id";
    when(repository.deleteAccount(any)).thenAnswer((realInvocation) async => Right(EmptyData()));

    final params = DeleteAccountUseCaseParams(userID);
    final result = await useCase(params);

    expect(result, Right(EmptyData()));
    verify(repository.deleteAccount(userID));
  });
}