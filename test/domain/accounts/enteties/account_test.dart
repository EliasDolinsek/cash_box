import 'package:cash_box/domain/account/enteties/account.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test("toJSON and fromJSON", () async {
    final testAccount = Account(AccountType.business, "elias.dolinsek@gmail.com", "password", "Elias Dolinsek");
    final accountMap = testAccount.toJSON();
    final fromJSON = Account.fromJSON(accountMap);

    expect(fromJSON, testAccount);
  });
}