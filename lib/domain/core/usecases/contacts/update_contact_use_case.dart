import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/enteties/contacts/contact.dart';
import 'package:cash_box/domain/core/enteties/fields/field.dart';
import 'package:cash_box/domain/core/repositories/contacts_repository.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:cash_box/domain/core/usecases/contacts/get_contact_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../use_case.dart';

class UpdateContactUseCase
    extends UseCase<EmptyData, UpdateContactUseCaseParams> {
  final ContactsRepository repository;

  UpdateContactUseCase(this.repository);

  @override
  Future<Either<Failure, EmptyData>> call(
      UpdateContactUseCaseParams params) async {
    final original = await _getOriginal(params.id);
    final update = Contact(params.id,
        name: params.name ?? original.name,
        fields: params.fields ?? original.fields);

    return repository.updateContact(params.id, update);
  }

  Future<Contact> _getOriginal(String id) async {
    final useCase = GetContactUseCase(repository);
    final params = GetContactUseCaseParams(id);

    final result = await useCase(params);
    return result.fold((l) => null, (contact) => contact);
  }
}

class UpdateContactUseCaseParams extends Equatable {
  final String id;
  final String name;
  final List<Field> fields;

  UpdateContactUseCaseParams(this.id, {this.name, this.fields})
      : super([id, name, fields]);
}
