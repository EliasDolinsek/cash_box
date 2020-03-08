import 'package:cash_box/domain/core/enteties/unique_component.dart';
import 'package:meta/meta.dart';

class Tag extends UniqueComponent {
  //Color in HEX
  final String name, color;

  Tag(String id, {@required this.name, @required this.color})
      : super(id, params: [name, color]);
}
