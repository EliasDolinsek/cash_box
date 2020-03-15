import 'package:equatable/equatable.dart';

abstract class BucketsState extends Equatable {
  const BucketsState();
}

class InitialBucketsState extends BucketsState {
  @override
  List<Object> get props => [];
}
