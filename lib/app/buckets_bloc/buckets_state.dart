import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:equatable/equatable.dart';

abstract class BucketsState extends Equatable {}

class InitialBucketsState extends BucketsState {
  @override
  List<Object> get props => [];
}

class BucketsAvailableState extends BucketsState {

  final List<Bucket> buckets;

  BucketsAvailableState(this.buckets);

  @override
  List get props => [buckets];

}

class BucketsUnavailableState extends BucketsState {}

class BucketsErrorState extends BucketsState {

  final String errorMessage;

  BucketsErrorState(this.errorMessage);
}

class BucketAvailableState extends BucketsState {

  final Bucket bucket;

  BucketAvailableState(this.bucket);

}
