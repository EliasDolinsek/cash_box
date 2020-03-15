import 'package:json_annotation/json_annotation.dart';
import 'package:cash_box/domain/core/enteties/unique_component.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../fields/field.dart';

part 'receipt.g.dart';

@JsonSerializable(nullable: false)
class Receipt extends UniqueComponent {
  final ReceiptType type;
  final DateTime creationDate;
  final List<Field> fields;
  final List<String> tagIDs;

  Receipt(String id,
      {@required this.type,
      @required this.creationDate,
      @required this.fields,
      @required this.tagIDs})
      : super(id, params: [
          type,
          creationDate.year,
          creationDate.month,
          creationDate.day,
          creationDate.hour,
          creationDate.minute,
          creationDate.second,
          fields,
          tagIDs
        ]);

  factory Receipt.newReceipt(
      {@required ReceiptType type,
      @required DateTime creationDate,
      @required List<Field> fields,
      @required List<String> tagIDs}) {

    final id = Uuid().v4();

    return Receipt(id,
        type: type, creationDate: creationDate, fields: fields, tagIDs: tagIDs);
  }

  factory Receipt.fromJson(Map<String, dynamic> json) =>
      _$ReceiptFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiptToJson(this);

  @override
  String toString() {
    return 'Receipt{type: $type, creationDate: $creationDate, fields: $fields, tagIDs: $tagIDs}';
  }
}

enum ReceiptType { income, outcome, investment, bank_statement }
