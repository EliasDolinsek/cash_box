import 'package:cash_box/domain/enteties/unique_component.dart';
import 'package:meta/meta.dart';

class Bucket extends UniqueComponent {
  final String name, description;
  final List<String> receiptsIDs;

  Bucket(String id,
      {@required this.name,
      @required this.description,
      @required this.receiptsIDs})
      : super(id, params: [name, description, receiptsIDs]);
}
