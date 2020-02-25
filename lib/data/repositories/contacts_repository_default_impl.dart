import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/enteties/contact.dart';
import 'package:cash_box/domain/repositories/contacts_repository.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';

class ContactsRepositoryDefaultImpl implements ContactsRepository {
  @override
  Future<Either<Failure, EmptyData>> addContact(Contact contact) {
    // TODO: implement addContact
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Contact>>> getContacts() {
    // TODO: implement getContacts
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, EmptyData>> removeContact(String id) {
    // TODO: implement removeContact
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, EmptyData>> updateContact(String id, Contact update) {
    // TODO: implement updateContact
    throw UnimplementedError();
  }

}