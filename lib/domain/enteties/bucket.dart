import 'package:cash_box/domain/enteties/unique_component.dart';

class Bucket extends UniqueComponent{

  final String name, description;
  final List<String> receiptsIDs;

  Bucket(String id, this.name, this.description, this.receiptsIDs) : super(id);

}