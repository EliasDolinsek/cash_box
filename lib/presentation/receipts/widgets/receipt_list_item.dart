import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:flutter/material.dart';

class ReceiptListItem extends StatelessWidget {

  final Receipt receipt;

  const ReceiptListItem({Key key, @required this.receipt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(_getIconForReceiptType()),
      ),
      title: Text(receipt.id),
    );
  }

  IconData _getIconForReceiptType() {
    switch (receipt.type) {
      case ReceiptType.income:
        return Icons.file_download;
      case ReceiptType.outcome:
        return Icons.file_upload;
    }
  }
}
