import 'package:cash_box/app/contacts_bloc/bloc.dart';
import 'package:cash_box/app/injection.dart';
import 'package:cash_box/domain/core/enteties/contacts/contact.dart';
import 'package:cash_box/domain/core/enteties/fields/field.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/base/width_constrained_widget.dart';
import 'package:cash_box/presentation/fields/field_card_widget.dart';
import 'package:cash_box/presentation/settings/dialogs/delete_dialog.dart';
import 'package:cash_box/presentation/widgets/text_input_widget.dart';
import 'package:flutter/material.dart';

class ContactDetailsPage extends StatefulWidget {
  final Contact contact;

  const ContactDetailsPage(this.contact, {Key key}) : super(key: key);

  @override
  _ContactDetailsPageState createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  bool _delete = false;
  String _name;
  List _fields;

  @override
  void initState() {
    super.initState();
    _name = widget.contact.name;
    _fields = widget.contact.fields;
  }

  @override
  void dispose() {
    if (!_delete) _updateContact();
    super.dispose();
  }

  void _updateContact() {
    final event =
        UpdateContactEvent(widget.contact.id, name: _name, fields: _fields);
    sl<ContactsBloc>().dispatch(event);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle()),
        backgroundColor: Colors.white,
        actions: <Widget>[_buildDeleteButton(context)],
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

  void _addEmptyField() {
    setState(() {
      final field = Field.newField(
          type: FieldType.text, description: "", value: "", storageOnly: true);
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

  Widget _buildNameFieldCardWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextInputWidget(
        title: AppLocalizations.translateOf(context, "txt_name"),
        initialValue: _name,
        onChanged: (value) {
          _name = value;
        },
      ),
    );
  }

  List<Widget> _getFieldsAsFieldCardWidgetList() {
    return _fields.map((field) {
      return Container(
        key: ValueKey(field),
        child: _buildFieldCardForField(field),
      );
    }).toList();
  }

  Widget _buildFieldCardForField(Field field) {
    return FieldWidget(
      field,
      onTap: () async {
        final result = await Navigator.of(context)
            .pushNamed("/fieldDetails", arguments: field);

        if(result != null && result is Field){
          final index = _fields.indexWhere((element) => element.id == result.id);
          setState(() {
            _fields.removeAt(index);
            _fields.insert(index, result);
          });
        }
      },
      onDelete: () {
        setState(() {
          _fields.remove(field);
        });
      },
    );
  }

  String _getAppBarTitle() {
    if (widget.contact.name.isEmpty) {
      return AppLocalizations.translateOf(context, "unnamed");
    } else {
      return widget.contact.name;
    }
  }

  Widget _buildDeleteButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.delete,
        color: Colors.red,
      ),
      onPressed: _showDeleteConfirmationDialog,
    );
  }

  void _showDeleteConfirmationDialog() async {
    final result =
        await showDialog(context: context, builder: (_) => DeleteDialog());
    if (result != null && result) {
      _removeContact(context);
    }
  }

  void _removeContact(BuildContext context) {
    final event = RemoveContactEvent(widget.contact.id);
    sl<ContactsBloc>().dispatch(event);

    _delete = true;
    Navigator.pop(context);
  }
}
