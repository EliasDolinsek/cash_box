import 'package:cash_box/domain/account/repositories/accounts_repository.dart';
import 'package:cash_box/domain/account/repositories/subscriptions_repository.dart';
import 'package:mockito/mockito.dart';

class MockAccountsRepository extends Mock implements AccountsRepository {}

class MockSubscriptionsRepository extends Mock implements SubscriptionsRepository {}