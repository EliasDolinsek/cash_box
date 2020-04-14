import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:cash_box/core/platform/entetie_converter.dart' as converter;

class ReceiptListItem extends StatelessWidget {
  final Receipt receipt;

  const ReceiptListItem({Key key, @required this.receipt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(_getIconForReceiptType()),
      ),
      title: Text(titleText(context)),
      subtitle: Text(
        converter.getDateAsReadableDate(receipt.creationDate),
      ),
    );
  }

  String titleText(BuildContext context) {
    if (receipt.fields != null && receipt.fields.isNotEmpty) {
      final text =
          converter.getFieldValueFromFieldAsString(receipt.fields.first);
      ;
      if (text.isEmpty) {
        return AppLocalizations.translateOf(context, "unnamed");
      } else {
        return text;
      }
    } else {
      return converter.getMonthAsReadableReceiptMonth(receipt.creationDate);
    }
  }

  IconData _getIconForReceiptType() {
    switch (receipt.type) {
      case ReceiptType.income:
        return Icons.file_download;
      case ReceiptType.outcome:
        return Icons.file_upload;
      default:
        return Icons.info_outline;
    }
  }
}
