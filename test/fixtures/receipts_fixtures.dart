import 'package:cash_box/domain/enteties/receipt.dart';
import 'field_fixtures.dart' as fieldFixtures;
import 'tag_ids_fixtures.dart' as tagFixtures;

List<Receipt> get receiptFixtures => [
  Receipt("abc-123", type: ReceiptType.INCOME, creationDate: DateTime.now(), fields: fieldFixtures.fieldFixtures, tagIDs: tagFixtures.tagFixtures),
  Receipt("def-456", type: ReceiptType.OUTCOME, creationDate: DateTime.now(), fields: fieldFixtures.fieldFixtures, tagIDs: tagFixtures.tagFixtures),
  Receipt("ghi-789", type: ReceiptType.INVESTMENT, creationDate: DateTime.now(), fields: fieldFixtures.fieldFixtures, tagIDs: tagFixtures.tagFixtures)
];