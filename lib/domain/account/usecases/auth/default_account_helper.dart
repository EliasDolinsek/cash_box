import 'package:cash_box/domain/account/enteties/account.dart';
import 'package:cash_box/domain/account/enteties/subscription.dart';
import 'package:meta/meta.dart';

Account getDefaultAccount({
  @required String userId,
  @required SignInSource signInSource,
  @required AccountType accountType,
  String email = "",
  String appPassword = "",
  String name = "",
}) {
  return Account(
    userID: userId,
    signInSource: signInSource,
    accountType: accountType,
    email: email,
    appPassword: appPassword,
    name: name,
    currencyCode: "EUR",
    subscriptionInfo: SubscriptionInfo(
      subscriptionType: _getSubscriptionTypeByAccountType(accountType),
      purchaseDate: DateTime.now(),
    ),
  );
}

SubscriptionType _getSubscriptionTypeByAccountType(AccountType accountType) {
  switch (accountType) {
    case AccountType.private:
      return SubscriptionType.personal_free;
    case AccountType.business:
      return SubscriptionType.business_free;
    default:
      throw new Exception(
          "Couldn't resolve default SubscriptionType for AccountType");
  }
}
