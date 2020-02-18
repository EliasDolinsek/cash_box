import 'package:cash_box/data/models/bucket_model.dart';
import 'package:cash_box/domain/enteties/bucket.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  final testBucketModel = BucketModel("id", name: "name", description: "description", receiptsIDs: ["abc-123"]);

  test("should test if BucketModel extends Bucket", (){
    expect(testBucketModel, isA<Bucket>());
  });
}