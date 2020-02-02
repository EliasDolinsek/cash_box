import 'package:cash_box/domain/enteties/template.dart';
import 'field_fixtures.dart';

List<Template> get templatesFixtures => [
  Template("abc-123", name: "Test1", fields: fieldFixtures),
  Template("def-456", name: "Test2", fields: fieldFixtures),
  Template("ghi-789", name: "Test3", fields: fieldFixtures),
];