import 'package:cash_box/domain/account/enteties/account.dart';
import 'package:cash_box/domain/account/enteties/subscription.dart';

List<Account> get accountFixtures => [
  Account(userID: "user-id-01", signInSource: SignInSource.firebase, accountType: AccountType.business, email: "email@email.com", appPassword: "password1", name: "name1", subscriptionInfo: SubscriptionInfo(subscriptionType: SubscriptionType.business_free, purchaseDate: DateTime.now())),
  Account(userID: "user-id.02", signInSource: SignInSource.firebase, accountType: AccountType.private, email: "gmail@gmail.com", appPassword: "password2", name: "name2", subscriptionInfo: SubscriptionInfo(subscriptionType: SubscriptionType.personal_free, purchaseDate: DateTime.now())),

];