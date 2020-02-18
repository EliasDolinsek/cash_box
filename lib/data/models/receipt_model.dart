import 'package:cash_box/domain/enteties/field.dart';
import 'package:cash_box/domain/enteties/receipt.dart';
import 'package:meta/meta.dart';

class ReceiptModel extends Receipt {

  ReceiptModel(String id,
      {@required ReceiptType type,
      @required DateTime creationDate,
      @required List<Field> fields,
      @required List<String> tagIDs})
      : super(
          id,
          type: type,
          creationDate: creationDate,
          fields: fields,
          tagIDs: tagIDs,
        );
}
