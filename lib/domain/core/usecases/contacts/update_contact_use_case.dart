import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/enteties/contact.dart';
import 'package:cash_box/domain/core/enteties/field.dart';
import 'package:cash_box/domain/core/repositories/contacts_repository.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../use_case.dart';

class UpdateContactUseCase extends UseCase<EmptyData, UpdateContactUseCaseParams> {

  final ContactsRepository repository;

  UpdateContactUseCase(this.repository);

  @override
  Future<Either<Failure, EmptyData>> call(UpdateContactUseCaseParams params) {
    final update = Contact(params.id, fields: params.fields);
    return repository.updateContact(params.id, update);
  }
}

class UpdateContactUseCaseParams extends Equatable {

  final String id;
  final List<Field> fields;

  UpdateContactUseCaseParams(this.id, this.fields) : super([id, fields]);
}