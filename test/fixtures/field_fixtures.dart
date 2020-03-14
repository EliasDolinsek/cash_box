import 'package:cash_box/domain/core/enteties/fields/field.dart';

List<Field> get fieldFixtures => [
  Field("abc-123", description: "description1", value: 12.5, type: FieldType.amount),
  Field("def-456", description: "description2", value: "value2", type: FieldType.text),
  Field("ghi-789", description: "description3", value: DateTime.fromMillisecondsSinceEpoch(1582299252124), type: FieldType.date),
];