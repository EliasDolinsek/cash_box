import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:equatable/equatable.dart';

abstract class BucketsEvent extends Equatable {}

class AddBucketEvent extends BucketsEvent {
  final Bucket bucket;

  AddBucketEvent(this.bucket);

  @override
  List get props => [bucket];
}

class AddReceiptToBucketEvent extends BucketsEvent {
  final String bucketID, receiptID;

  AddReceiptToBucketEvent(this.bucketID, this.receiptID);

  @override
  List get props => [bucketID, receiptID];
}

class GetBucketEvent extends BucketsEvent {
  final String bucketID;

  GetBucketEvent(this.bucketID);

  @override
  List get props => [bucketID];
}

class GetBucketsEvent extends BucketsEvent {}

class RemoveBucketEvent extends BucketsEvent {

  final String bucketID;

  RemoveBucketEvent(this.bucketID);

  @override
  List get props => [bucketID];
}

class RemoveReceiptFromBucketEvent extends BucketsEvent {

  final String receiptID, bucketID;

  RemoveReceiptFromBucketEvent(this.receiptID, this.bucketID);

  @override
  List get props => [receiptID, bucketID];
}

class UpdateBucketEvent extends BucketsEvent {

  final String id;
  final String name, description;
  final List<String> receiptIDs;

  UpdateBucketEvent({this.id, this.name, this.description, this.receiptIDs});

  @override
  List get props => [id, name, description, receiptIDs];
}