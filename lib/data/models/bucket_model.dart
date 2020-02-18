import 'package:cash_box/domain/enteties/bucket.dart';
import 'package:meta/meta.dart';

class BucketModel extends Bucket {

  BucketModel(String id,
      {@required String name,
      @required String description,
      @required List<String> receiptsIDs})
      : super(id,
            name: name, description: description, receiptsIDs: receiptsIDs);
}
