import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../use_case.dart';

class FormatCurrencyUseCase
    extends SecureSyncUseCase<String, FormatCurrencyUseCaseParams> {

  @override
  String call(FormatCurrencyUseCaseParams params) {
    return NumberFormat.compactCurrency(decimalDigits: 2, symbol: params.symbol)
        .format(params.amount);
  }
}

class FormatCurrencyUseCaseParams extends Equatable {
  final double amount;
  final String symbol;

  FormatCurrencyUseCaseParams({@required this.amount, @required this.symbol});
}
