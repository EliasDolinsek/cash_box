import 'package:cash_box/domain/core/enteties/receipt.dart';
import 'field_fixtures.dart' as fieldFixtures;
import 'tag_ids_fixtures.dart' as tagFixtures;

List<Receipt> get receiptFixtures => [
  Receipt("abc-123", type: ReceiptType.income, creationDate: DateTime(2020), fields: fieldFixtures.fieldFixtures, tagIDs: tagFixtures.tagIDFixtures),
  Receipt("def-456", type: ReceiptType.outcome, creationDate: DateTime(2020), fields: fieldFixtures.fieldFixtures, tagIDs: tagFixtures.tagIDFixtures),
  Receipt("ghi-789", type: ReceiptType.investment, creationDate: DateTime(2020), fields: fieldFixtures.fieldFixtures, tagIDs: tagFixtures.tagIDFixtures)
];