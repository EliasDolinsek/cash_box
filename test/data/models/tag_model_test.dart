import 'package:cash_box/data/models/tag_model.dart';
import 'package:cash_box/domain/enteties/tag.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  final testTag = TagModel("abc-123", name: "name", color: "color");

  test("should test if TagModel extends Tag", (){
    expect(testTag, isA<Tag>());
  });

  test("toMAP and fromMAP", (){
    final map = testTag.toMap();
    final tagModelFroMMap = TagModel.fromMap(map);
    expect(testTag, tagModelFroMMap);
  });
}