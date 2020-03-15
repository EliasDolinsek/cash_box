import 'package:equatable/equatable.dart';

class ReceiptMonth extends Equatable {

  final DateTime month;

  ReceiptMonth(this.month);

  int get monthAsInt => month.month;
  int get yearAsInt => month.year;

  @override
  List get props => [month];
}