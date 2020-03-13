import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/data/core/repositories/repository.dart';
import 'package:cash_box/domain/core/enteties/contacts/contact.dart';
import 'package:dartz/dartz.dart';

import 'empty_data.dart';

abstract class ContactsRepository implements Repository{

  Future<Either<Failure, List<Contact>>> getContacts();
  Future<Either<Failure, EmptyData>> addContact(Contact contact);
  Future<Either<Failure, EmptyData>> removeContact(String id);
  Future<Either<Failure, EmptyData>> updateContact(String id, Contact update);

}