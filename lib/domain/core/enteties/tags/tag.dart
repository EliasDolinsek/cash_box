import 'package:json_annotation/json_annotation.dart';
import 'package:cash_box/domain/core/enteties/unique_component.dart';
import 'package:meta/meta.dart';

part 'tag.g.dart';

@JsonSerializable(nullable: false)
class Tag extends UniqueComponent {
  //Color in HEX
  final String name, color;

  Tag(String id, {@required this.name, @required this.color})
      : super(id, params: [name, color]);

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

  Map<String, dynamic> toJson() => _$TagToJson(this);
}
