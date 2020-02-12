import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/enteties/contact.dart';
import 'package:cash_box/domain/repositories/contacts_repository.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:cash_box/domain/usecases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

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