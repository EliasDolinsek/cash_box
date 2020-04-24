import 'package:cash_box/core/platform/constants.dart';
import 'package:cash_box/domain/core/enteties/fields/field.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:cash_box/core/platform/entetie_converter.dart' as converter;

class ReceiptListItem extends StatelessWidget {
  final Receipt receipt;
  final Function onTap;

  const ReceiptListItem({Key key, @required this.receipt, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        child: _getIconForReceiptType(),
      ),
      title: Text(titleText(context)),
      subtitle: Text(
        converter.getDateAsReadableDate(receipt.creationDate),
      ),
    );
  }

  String titleText(BuildContext context) {
    if (receipt.fields != null && receipt.fields.isNotEmpty) {
      final text = getTitleForReceiptFromFields(receipt.fields);
      if (text.isEmpty) {
        return AppLocalizations.translateOf(context, "unnamed");
      } else {
        return text;
      }
    } else {
      return converter.getMonthAsReadableReceiptMonth(receipt.creationDate);
    }
  }

  String getTitleForReceiptFromFields(List<Field> fields) {
    final title = fields
        .firstWhere(
            (element) => !element.storageOnly && element.type == FieldType.text,
            orElse: () => null)
        ?.value;

    if(title != null && title.isNotEmpty){
      return title;
    } else {
      return converter.getFieldValueFromFieldAsString(receipt.fields.first);
    }
  }

  Icon _getIconForReceiptType() {
    switch (receipt.type) {
      case ReceiptType.income:
        return Icon(Icons.add);
      case ReceiptType.outcome:
        return Icon(Icons.remove);
      default:
        return Icon(Icons.info_outline);
    }
  }
}
