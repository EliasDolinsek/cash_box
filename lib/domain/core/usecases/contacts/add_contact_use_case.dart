import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/enteties/contact.dart';
import 'package:cash_box/domain/core/repositories/contacts_repository.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../use_case.dart';

class AddContactUseCase extends UseCase<EmptyData, AddContactParams> {

  final ContactsRepository repository;

  AddContactUseCase(this.repository);

  @override
  Future<Either<Failure, EmptyData>> call(AddContactParams params) {
    return repository.addContact(params.contact);
  }

}

class AddContactParams extends Equatable {

  final Contact contact;

  AddContactParams(this.contact) : super([contact]);

}