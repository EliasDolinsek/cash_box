import 'package:cash_box/domain/enteties/unique_component.dart';

class Tag extends UniqueComponent{

  //Color in HEX
  final String name, color;

  Tag(String id, this.name, this.color) : super(id);

}