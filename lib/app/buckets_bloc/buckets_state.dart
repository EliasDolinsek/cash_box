import 'package:cash_box/domain/core/enteties/buckets/bucket.dart';
import 'package:equatable/equatable.dart';

abstract class BucketsState extends Equatable {}

class BucketsAvailableState extends BucketsState {
  final List<Bucket> buckets;

  BucketsAvailableState(this.buckets);

  @override
  List get props => [buckets];
}

class BucketsLoadingState extends BucketsState {}
