import 'package:cash_box/domain/core/enteties/contacts/contact.dart';

import 'field_fixtures.dart';

List<Contact> get contactFixtures => [
  Contact("abc-123", fields: fieldFixtures),
  Contact("def-456", fields: fieldFixtures),
  Contact("ghi-789", fields: fieldFixtures),
];