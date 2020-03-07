import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/data/repositories/repository.dart';
import 'package:cash_box/domain/enteties/contact.dart';
import 'package:cash_box/domain/repositories/empty_data.dart';
import 'package:dartz/dartz.dart';

abstract class ContactsRepository implements Repository{

  Future<Either<Failure, List<Contact>>> getContacts();
  Future<Either<Failure, EmptyData>> addContact(Contact contact);
  Future<Either<Failure, EmptyData>> removeContact(String id);
  Future<Either<Failure, EmptyData>> updateContact(String id, Contact update);

}