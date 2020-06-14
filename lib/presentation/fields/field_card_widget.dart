import 'package:cash_box/core/platform/entetie_converter.dart';
import 'package:cash_box/domain/core/enteties/fields/field.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/settings/dialogs/delete_dialog.dart';
import 'package:cash_box/presentation/widgets/content_card_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cash_box/core/platform/input_converter.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class FieldWidget extends StatelessWidget {
  final Field field;
  final Function onDelete;
  final Function onTap;

  const FieldWidget(this.field, {Key key, this.onDelete, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        field.description != null && field.description.isNotEmpty
            ? field.description
            : AppLocalizations.translateOf(context, "unnamed"),
      ),
      subtitle:
          Text(getFieldTypeAsString(field.type, AppLocalizations.of(context))),
      onTap: onTap,
    );
  }
}
