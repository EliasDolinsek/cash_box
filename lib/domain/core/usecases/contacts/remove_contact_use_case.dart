import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/repositories/contacts_repository.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../use_case.dart';

class RemoveContactUseCase extends UseCase<EmptyData, RemoveContactUseCaseParams> {

  final ContactsRepository repository;

  RemoveContactUseCase(this.repository);

  @override
  Future<Either<Failure, EmptyData>> call(RemoveContactUseCaseParams params) {
    return repository.removeContact(params.id);
  }

}

class RemoveContactUseCaseParams extends Equatable {

  final String id;

  RemoveContactUseCaseParams(this.id) : super([id]);

}