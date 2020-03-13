import 'package:cash_box/domain/core/enteties/tags/tag.dart';

List<String> get tagIDFixtures => ["abc-123", "def-456", "hij-789"];
List<Tag> get tagFixtures => [
  Tag("abc-123", name: "Test", color: ""),
  Tag("def-456", name: "Test1", color: ""),
  Tag("ghi-789", name: "Test2", color: ""),
];