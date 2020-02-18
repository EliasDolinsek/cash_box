import 'package:cash_box/domain/enteties/tag.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  final testTag = Tag("abc-123", name: "name", color: "color");

  test("should test if TagModel extends Tag", (){
    expect(testTag, isA<Tag>());
  });
}