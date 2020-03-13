import 'package:json_annotation/json_annotation.dart';
import 'package:cash_box/domain/core/enteties/unique_component.dart';
import 'package:meta/meta.dart';

part 'bucket.g.dart';

@JsonSerializable(nullable: false)
class Bucket extends UniqueComponent {
  final String name, description;
  final List<String> receiptsIDs;

  Bucket(String id,
      {@required this.name,
      @required this.description,
      @required this.receiptsIDs})
      : super(id, params: [name, description, receiptsIDs]);

  factory Bucket.fromJson(Map<String, dynamic> json) => _$BucketFromJson(json);

  Map<String, dynamic> toJson() => _$BucketToJson(this);
}
