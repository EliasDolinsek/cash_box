import 'package:equatable/equatable.dart';

abstract class PurchasesState extends Equatable {
  const PurchasesState();
}

class InitialPurchasesState extends PurchasesState {
  @override
  List<Object> get props => [];
}
