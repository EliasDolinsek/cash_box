import 'package:cash_box/app/accounts_bloc/accounts_bloc.dart';
import 'package:cash_box/app/accounts_bloc/accounts_state.dart';
import 'package:cash_box/app/injection.dart';
import 'package:cash_box/domain/account/enteties/currencies.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/presentation/receipts/widgets/receipt_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReceiptsOverviewWidget extends StatelessWidget {
  final List<Receipt> receipts;
  final Function(Receipt receipt) onTap;

  const ReceiptsOverviewWidget({Key key, @required this.receipts, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    receipts.sort(
          (a, b) =>
          b.creationDate.millisecondsSinceEpoch
              .compareTo(a.creationDate.millisecondsSinceEpoch),
    );
    return BlocBuilder(
      bloc: sl<AccountsBloc>(),
      builder: (context, state) {
        if (state is AccountAvailableState) {
          final currencySymbol = currencySymbolFromCode(state.account?.currencyCode);
          return _buildReceiptsList(currencySymbol);
        } else {
          return _buildReceiptsList("");
        }
      },
    );
  }

  Widget _buildReceiptsList(String currencySymbol) {
    return Column(
      children: receipts
          .map((receipt) {
          return ReceiptListItem(
            receipt: receipt,
            onTap: () => onTap != null ? onTap(receipt) : null,
            currencySymbol: currencySymbol,
          );
        },
      ).toList(),
    );
  }
}
