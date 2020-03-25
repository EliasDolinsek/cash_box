import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cash_box/domain/core/enteties/unique_component.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'tag.g.dart';

@JsonSerializable(nullable: false)
class Tag extends UniqueComponent {
  //Color in HEX
  final String name, color;

  Tag(String id, {@required this.name, @required this.color})
      : super(id, params: [name, color]);

  factory Tag.newTag({@required String name, @required String color}){
    final id = Uuid().v4();

    return Tag(id, name: name, color: color);
  }

  Color get colorAsColor {
    int colorAsInt = int.parse(color, radix: 16);
    return Color(colorAsInt);
  }

  static String colorAsString(Color color) => color.value.toRadixString(16);

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

  Map<String, dynamic> toJson() => _$TagToJson(this);
}
