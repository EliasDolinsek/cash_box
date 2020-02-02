import 'package:cash_box/domain/enteties/bucket.dart';

List<Bucket> get bucketFixtures => [
  Bucket("abc-123", name: "Test1", description: "Description1", receiptsIDs: _defaultReceiptIDs),
  Bucket("def-456", name: "Test2", description: "Description2", receiptsIDs: _defaultReceiptIDs),
  Bucket("ghi-789", name: "Test3", description: "Description3", receiptsIDs: _defaultReceiptIDs)
];

List<String> get _defaultReceiptIDs => [
  "abc-123",
  "def-456",
  "ghi-789"
];