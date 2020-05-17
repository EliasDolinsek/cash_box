import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/domain/core/enteties/contacts/contact.dart';
import 'package:cash_box/domain/core/repositories/contacts_repository.dart';
import 'package:dartz/dartz.dart';

import '../use_case.dart';

class GetContactsUseCase extends AsyncUseCase<List<Contact>, NoParams> {

  final ContactsRepository repository;

  GetContactsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Contact>>> call(NoParams params) {
    return repository.getContacts();
  }

}