import 'package:cash_box/app/injection.dart';
import 'package:cash_box/app/templates_bloc/bloc.dart';
import 'package:cash_box/app/templates_bloc/templates_event.dart';
import 'package:cash_box/domain/core/enteties/fields/field.dart';
import 'package:cash_box/domain/core/enteties/templates/template.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/base/width_constrained_widget.dart';
import 'package:cash_box/presentation/fields/field_widgets.dart';
import 'package:cash_box/presentation/settings/dialogs/delete_dialog.dart';
import 'package:cash_box/presentation/widgets/text_input_widget.dart';
import 'package:flutter/material.dart';

class ReceiptTemplateDetailsPage extends StatefulWidget {
  final Template template;

  const ReceiptTemplateDetailsPage(this.template, {Key key}) : super(key: key);

  @override
  _ReceiptTemplateDetailsPageState createState() =>
      _ReceiptTemplateDetailsPageState();
}

class _ReceiptTemplateDetailsPageState
    extends State<ReceiptTemplateDetailsPage> {
  bool _delete = false;
  String _name;
  List<Field> _fields;

  @override
  void initState() {
    super.initState();
    _name = widget.template.name;
    _fields = widget.template.fields;
  }

  @override
  void dispose() {
    super.dispose();
    if (!_delete) {
      final event = UpdateTemplateEvent(
        widget.template.id,
        name: _name,
        fields: _fields,
      );

      sl<TemplatesBloc>().dispatch(event);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle()),
        backgroundColor: Colors.white,
        actions: <Widget>[_buildDeleteButton()],
      ),
      body: Center(child: WidthConstrainedWidget(child: _buildListView())),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addEmptyField,
        label: Text(AppLocalizations.translateOf(context, "btn_add_field")),
        icon: Icon(Icons.add),
      ),
    );
  }

  void _addEmptyField() async {
    final field = Field.newField(
        type: FieldType.text, description: "", value: "", storageOnly: true);

    final result = await Navigator.of(context)
        .pushNamed("/fieldDetails", arguments: field);

    if (result != null) {
      setState(() => _fields.add(result));
    }
  }

  Widget _buildListView() {
    return ReorderableListView(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      header: _buildNameFieldCardWidget(),
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }

          final field = _fields.removeAt(oldIndex);
          _fields.insert(newIndex, field);
        });
      },
      children: _getFieldsAsFieldCardWidgetList(),
    );
  }

  List<Widget> _getFieldsAsFieldCardWidgetList() {
    return _fields.map((field) {
      return Container(
        key: ValueKey(field),
        child: _buildFieldWidget(field),
      );
    }).toList();
  }

  Widget _buildFieldWidget(Field field) {
    return FieldDetailWidget(
      field,
      onTap: () async {
        final result = await Navigator.pushNamed(
          context,
          "/fieldDetails",
          arguments: field,
        );

        if (result != null && result is Field) {
          final index = _fields.indexWhere(
            (element) => element.id == result.id,
          );

          setState(() {
            _fields.removeAt(index);
            _fields.insert(index, result);
          });
        }
      },
    );
  }

  String _getAppBarTitle() {
    if (widget.template.name.isEmpty) {
      return AppLocalizations.translateOf(context, "unnamed");
    } else {
      return widget.template.name;
    }
  }

  Widget _buildNameFieldCardWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextInputWidget(
        title: AppLocalizations.translateOf(context, "txt_name"),
        onChanged: (value) {
          _name = value;
        },
        initialValue: _name,
      ),
    );
  }

  Widget _buildDeleteButton() {
    return IconButton(
      icon: Icon(
        Icons.delete,
        color: Colors.red,
      ),
      onPressed: _checkAndDeleteTemplate,
    );
  }

  void _checkAndDeleteTemplate() async {
    final result =
        await showDialog(context: context, builder: (_) => DeleteDialog());
    if (result != null && result) {
      _deleteTemplate();
      Navigator.of(context).pop();
    }
  }

  void _deleteTemplate() {
    final event = RemoveTemplateEvent(widget.template.id);
    sl<TemplatesBloc>().dispatch(event);
  }
}
