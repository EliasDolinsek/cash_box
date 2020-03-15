import 'package:equatable/equatable.dart';

abstract class ReceiptsBlocState extends Equatable {
  const ReceiptsBlocState();
}

class InitialReceiptsBlocState extends ReceiptsBlocState {
  @override
  List<Object> get props => [];
}
