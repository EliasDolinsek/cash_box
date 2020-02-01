import 'package:cash_box/domain/enteties/receipt.dart';
import 'field_fixtures.dart' as fieldFixtures;
import 'tags_fixtures.dart' as tagFixtures;

final List<Receipt> receiptFixtures = [
  Receipt("abc-123", type: ReceiptType.INCOME, creationDate: DateTime.now(), fields: fieldFixtures.fieldFixtures, tagIDs: tagFixtures.tagFixtures),
  Receipt("def-456", type: ReceiptType.OUTCOME, creationDate: DateTime.now(), fields: fieldFixtures.fieldFixtures, tagIDs: tagFixtures.tagFixtures),
  Receipt("ghi-789", type: ReceiptType.INVESTMENT, creationDate: DateTime.now(), fields: fieldFixtures.fieldFixtures, tagIDs: tagFixtures.tagFixtures)
];