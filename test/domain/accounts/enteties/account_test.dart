import 'package:cash_box/domain/account/enteties/account.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("toJSON and fromJSON", () async {
    final testAccount = Account(
        name: "Elias Dolinsek",
        email: "elias.dolinsek@gmail.com",
        accountType: AccountType.business,
        password: "Test",
        signInSource: SignInSource.firebase,
        userID: "user-id-01");

    final accountMap = testAccount.toJSON();
    final fromJSON = Account.fromJSON(accountMap);

    expect(fromJSON, testAccount);
  });
}
