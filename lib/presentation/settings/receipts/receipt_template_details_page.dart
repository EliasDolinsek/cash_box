import 'package:cash_box/app/injection.dart';
import 'package:cash_box/app/templates_bloc/bloc.dart';
import 'package:cash_box/app/templates_bloc/templates_event.dart';
import 'package:cash_box/domain/core/enteties/fields/field.dart';
import 'package:cash_box/domain/core/enteties/templates/template.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/fields/field_card_widget.dart';
import 'package:cash_box/presentation/settings/dialogs/delete_dialog.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle()),
        backgroundColor: Colors.white,
        actions: <Widget>[_buildDeleteButton()],
      ),
      body: _buildListView(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addEmptyField,
        label: Text(AppLocalizations.translateOf(context, "btn_add_field")),
        icon: Icon(Icons.add),
      ),
    );
  }

  void _addEmptyField() {
    setState(() {
      final field = Field.newField(
          type: FieldType.text, description: "", value: "");
      _fields.add(field);
    });
  }

  Widget _buildListView() {
    return ReorderableListView(
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
      return FieldCard(
        field,
        key: ValueKey(field),
        onFieldChanged: (update) {
          final index = _fields.indexWhere((element) =>
          element.id == update.id);
          _fields.removeAt(index);
          _fields.insert(index, update);
        },
        onDelete: () {
          setState(() {
            _fields.remove(field);
          });
        },
      );
    }).toList();
  }

  String _getAppBarTitle() {
    if (widget.template.name.isEmpty) {
      return AppLocalizations.translateOf(context, "unnamed");
    } else {
      return widget.template.name;
    }
  }

  Widget _buildNameFieldCardWidget() {
    final field =
    Field.newField(type: FieldType.text, description: "Name", value: _name);
    return FieldCard(
      field,
      deletable: false,
      descriptionEditable: false,
      typeEditable: false,
      onFieldChanged: (Field field) {
        _name = field.value;
      },
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