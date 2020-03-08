import 'package:cash_box/data/core/models/field_model.dart';
import 'package:cash_box/domain/core/enteties/field.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  final testFieldModel = FieldModel("abc-123", description: "test", value: null);

  test("should test if FieldModel extends Field", (){
    expect(testFieldModel, isA<FieldModel>());
  });

  group("toMAP", (){
    test("toMAP for FieldType.TEXT", () async {
      final testText = "Test";
      final testModel = FieldModel("abc-123", type: FieldType.TEXT, description: "description", value: testText);
      final map = testModel.toMap();

      expect(map, {"id":"abc-123", "type":"text", "description":"description", "value":testText});
    });

    test("toMAP for FieldType.AMOUNT", () async {
      final testAmount = 12.5;
      final testModel = FieldModel("abc-123", type: FieldType.AMOUNT, description: "description", value: testAmount);
      final map = testModel.toMap();

      expect(map, {"id":"abc-123", "type":"amount", "description":"description", "value":testAmount});
    });

    test("toMAP for FieldType.DATE", () async {
      final testDate = DateTime.now();
      final testModel = FieldModel("abc-123", type: FieldType.DATE, description: "description", value: testDate);
      final map = testModel.toMap();

      expect(map, {"id":"abc-123", "type":"date", "description":"description", "value":testDate.millisecondsSinceEpoch});
    });

    test("toMAP for FieldType.IMAGE", () async {
      final testImageSrc = "firebase:image-id";
      final testModel = FieldModel("abc-123", type: FieldType.IMAGE, description: "description", value: testImageSrc);
      final map = testModel.toMap();

      expect(map, {"id":"abc-123", "type":"image", "description":"description", "value":testImageSrc});
    });

    test("toMAP for FieldType.FILE", () async {
      final testFileSrc = "firebase:file-id";
      final testModel = FieldModel("abc-123", type: FieldType.FILE, description: "description", value: testFileSrc);
      final map = testModel.toMap();

      expect(map, {"id":"abc-123", "type":"file", "description":"description", "value":testFileSrc});
    });
  });

  group("fromMap", (){
    test("fromMap for FieldType.TEXT", () {
      final testText = "Test";
      final testMAP = {"id":"abc-123", "type":"text", "description":"description", "value":testText};

      final result = FieldModel.fromMap(testMAP);
      expect(result, FieldModel("abc-123", type: FieldType.TEXT, description: "description", value: testText));
    });

    test("fromMap for FieldType.AMOUNT", (){
      final testAmount = 12.5;
      final testMAP = {"id":"abc-123", "type":"amount", "description":"description", "value":testAmount};

      final result = FieldModel.fromMap(testMAP);
      expect(result, FieldModel("abc-123", type: FieldType.AMOUNT, description: "description", value: testAmount));
    });

    test("fromMap for FieldType.DATE", (){
      final testDate = DateTime.now();
      final testMAP = {"id":"abc-123", "type":"date", "description":"description", "value":testDate.millisecondsSinceEpoch};

      final result = FieldModel.fromMap(testMAP);
      expect(result.toMap(), FieldModel("abc-123", type: FieldType.DATE, description: "description", value: testDate).toMap());
    });

    test("fromMap for FieldType.IMAGE", (){
      final testImageSrc = "local:image-name";
      final testMAP = {"id":"abc-123", "type":"image", "description":"description", "value":testImageSrc};

      final result = FieldModel.fromMap(testMAP);
      expect(result, FieldModel("abc-123", type: FieldType.IMAGE, description: "description", value: testImageSrc));
    });

    test("fromMap for FieldType.FILE", (){
      final testFileSrc = "local:file-name";
      final testMAP = {"id":"abc-123", "type":"file", "description":"description", "value":testFileSrc};

      final result = FieldModel.fromMap(testMAP);
      expect(result, FieldModel("abc-123", type: FieldType.FILE, description: "description", value: testFileSrc));
    });
  });
}