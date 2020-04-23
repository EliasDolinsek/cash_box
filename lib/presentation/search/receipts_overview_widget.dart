import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/presentation/receipts/widgets/receipt_list_item.dart';
import 'package:flutter/material.dart';

class ReceiptsOverviewWidget extends StatelessWidget {
  final List<Receipt> receipts;
  final Function(Receipt receipt) onTap;

  const ReceiptsOverviewWidget({Key key, @required this.receipts, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: receipts
          .map(
            (receipt) => ReceiptListItem(
              receipt: receipt,
              onTap: () => onTap != null ? onTap(receipt) : null,
            ),
          )
          .toList(),
    );
  }
}
