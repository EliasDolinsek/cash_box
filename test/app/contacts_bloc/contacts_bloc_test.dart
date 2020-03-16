
import 'package:cash_box/app/contacts_bloc/bloc.dart';
import 'package:cash_box/domain/core/usecases/contacts/add_contact_use_case.dart';
import 'package:cash_box/domain/core/usecases/contacts/get_contact_use_case.dart';
import 'package:cash_box/domain/core/usecases/contacts/remove_contact_use_case.dart';
import 'package:cash_box/domain/core/usecases/contacts/update_contact_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAddContactUseCase extends Mock implements AddContactUseCase {}

class MockGetContactUseCase extends Mock implements GetContactUseCase {}

class MockGetContactsUseCase extends Mock implements GetContactUseCase {}

class MockRemoveContactUseCase extends Mock implements RemoveContactUseCase {}

class MockUpdateContactUseCase extends Mock implements UpdateContactUseCase {}

void main(){

  final MockAddContactUseCase addContactUseCase = MockAddContactUseCase();
  final MockGetContactUseCase getContactUseCase = MockGetContactUseCase();
  final MockGetContactsUseCase getContactsUseCase = MockGetContactsUseCase();
  final MockRemoveContactUseCase removeContactUseCase = MockRemoveContactUseCase();
  final MockUpdateContactUseCase updateContactUseCase = MockUpdateContactUseCase();
  
  ContactsBloc contactsBloc;
  
  setUp((){
    contactsBloc = ContactsBloc();
  });
}