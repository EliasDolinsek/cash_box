import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/enteties/contact.dart';
import 'package:cash_box/domain/repositories/contacts_repository.dart';
import 'package:cash_box/domain/usecases/use_case.dart';
import 'package:dartz/dartz.dart';

class GetContactsUseCase extends UseCase<List<Contact>, NoParams> {

  final ContactsRepository repository;

  GetContactsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Contact>>> call(NoParams params) {
    return repository.getContacts();
  }

}