import 'package:cash_box/domain/core/enteties/fields/field.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/fields/field_widgets.dart';
import 'package:cash_box/presentation/widgets/component_action_button.dart';
import 'package:flutter/material.dart';

class TemplateSelectionWidget extends StatefulWidget {
  final List<Field> initialFields;
  final Function(List<Field> fields) onFieldsChanged;

  const TemplateSelectionWidget(
      {Key key, @required this.onFieldsChanged, this.initialFields = const []})
      : super(key: key);

  @override
  _TemplateSelectionWidgetState createState() =>
      _TemplateSelectionWidgetState();
}

class _TemplateSelectionWidgetState extends State<TemplateSelectionWidget> {
  List<Field> fields;

  @override
  void initState() {
    super.initState();
    fields = widget.initialFields;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ComponentActionButton(
          text: AppLocalizations.translateOf(context, "btn_select_template"),
          onPressed: () async {
            final result =
                await Navigator.of(context).pushNamed("/templateSelection");
            if(result != null){
              fields = result;
              widget.onFieldsChanged(fields);
            }
          },
        ),
        SizedBox(height: 8.0),
      ]..addAll(fields.map((e) => _buildFieldInputWidgetForField(e)).toList()),
    );
  }

  Widget _buildFieldInputWidgetForField(Field e) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: FieldInputWidget(
        field: e,
        onChanged: (field) {
          final indexOfField = fields.indexWhere((element) {
            return element.id == field.id;
          });

          widget.onFieldsChanged(fields);

          setState(() {
            fields.removeAt(indexOfField);
            fields.insert(indexOfField, field);
          });
        },
      ),
    );
  }
}
