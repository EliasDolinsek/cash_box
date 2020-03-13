import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/enteties/contacts/contact.dart';
import 'package:cash_box/domain/core/repositories/contacts_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecases/use_case.dart';

class GetContactUseCase extends UseCase<Contact, GetContactUseCaseParams> {

  final ContactsRepository repository;

  GetContactUseCase(this.repository);

  @override
  Future<Either<Failure, Contact>> call(GetContactUseCaseParams params) async {
    final contactsEither = await repository.getContacts();
    return contactsEither.fold((failure) => Left(failure), (contacts){
      final contact = _getContactByID(params.id, contacts);
      if(contact == null){
        return Left(ContactNotFoundFailure());
      } else {
        return Right(contact);
      }
    });
  }

  Contact _getContactByID(String id, List<Contact> contacts){
    return contacts.firstWhere((c) => c.id == id, orElse: () => null);
  }

}

class GetContactUseCaseParams extends Equatable {

  final String id;

  GetContactUseCaseParams(this.id) : super([id]);

}