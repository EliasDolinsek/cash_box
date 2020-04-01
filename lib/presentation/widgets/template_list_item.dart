import 'package:cash_box/domain/core/enteties/templates/template.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:flutter/material.dart';

class TemplateListItem extends StatelessWidget {

  final Function onTap;
  final Template template;

  const TemplateListItem(this.template, {Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_getTemplateNameText(context)),
      subtitle: Text(_templateFieldsInfoAsString(context)),
      onTap: onTap,
    );
  }

  String _getTemplateNameText(BuildContext context) {
    if (template.name.isEmpty) {
      return AppLocalizations.translateOf(context, "unnamed");
    } else {
      return template.name;
    }
  }

  String _templateFieldsInfoAsString(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    if (template.fields.isEmpty) {
      return localizations.translate("txt_no_fields");
    } else {
      return template.fields.map((f) {
        return f.description;
      }).join(" · ");
    }
  }
}