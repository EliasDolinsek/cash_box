import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/repositories/contacts_repository.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:cash_box/domain/usecases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

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