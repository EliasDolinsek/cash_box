import 'package:cash_box/domain/core/enteties/templates/template.dart';
import 'field_fixtures.dart';

List<Template> get templateFixtures => [
  Template("abc-123", name: "Test1", fields: fieldFixtures),
  Template("def-456", name: "Test2", fields: fieldFixtures),
  Template("ghi-789", name: "Test3", fields: fieldFixtures),
];