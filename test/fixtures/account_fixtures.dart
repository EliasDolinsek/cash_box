import 'package:cash_box/domain/account/enteties/account.dart';

List<Account> get accountFixtures => [
  Account(userID: "user-id-01", signInSource: SignInSource.firebase, accountType: AccountType.business, email: "email@email.com", password: "password1", name: "name1"),
  Account(userID: "user-id.02", signInSource: SignInSource.firebase, accountType: AccountType.private, email: "gmail@gmail.com", password: "password2", name: "name2"),

];