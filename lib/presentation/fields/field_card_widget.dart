import 'package:cash_box/core/platform/entetie_converter.dart';
import 'package:cash_box/domain/core/enteties/fields/field.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/settings/dialogs/delete_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class FieldCard extends StatefulWidget {
  final Field field;
  final bool typeEditable, descriptionEditable, deletable;

  final Function(Field update) onFieldChanged;
  final Function onDelete;

  const FieldCard(this.field,
      {Key key,
      this.typeEditable = true,
      this.descriptionEditable = true,
      this.deletable = true,
      this.onFieldChanged,
      this.onDelete})
      : super(key: key);

  @override
  _FieldCardState createState() => _FieldCardState();
}

class _FieldCardState extends State<FieldCard> {
  String _description;
  dynamic _value;
  FieldType _type;

  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _type = widget.field.type;
    _description = widget.field.description;
    _value = widget.field.value;
    _initValue();

    _descriptionController.text = _description;
    _descriptionController.addListener(() {
      _description = _descriptionController.text;
      widget.onFieldChanged(_getFieldFromInputs());
    });
  }

  void _initValue() {
    if (_type == FieldType.date) {
      if (_value is Timestamp) {
        _value = _value.toDate();
      }
    } else if (_type == FieldType.text && _value == null) {
      _value = "";
    }
  }

  Field _getFieldFromInputs() {
    return Field(widget.field.id,
        type: _type, description: _description, value: _value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTitleTypeBar(),
            SizedBox(height: 8.0),
            _buildValueInput(),
            SizedBox(height: 8.0),
            _buildFieldTypeSelectionChipsIfNessesscary(),
            SizedBox(height: 8.0),
            _checkAndBuildDeleteButton()
          ],
        ),
      ),
    );
  }

  Widget _checkAndBuildDeleteButton() {
    if (widget.deletable) {
      return MaterialButton(
        child: Text(
          AppLocalizations.translateOf(context, "btn_delete"),
          style: TextStyle(color: Colors.red),
        ),
        onPressed: _showDeleteButton,
      );
    } else {
      return Container();
    }
  }

  void _showDeleteButton() async {
    final result =
        await showDialog(context: context, builder: (_) => DeleteDialog());
    if(result != null && result){
      widget.onDelete();
    }
  }

  Widget _buildFieldTypeSelectionChipsIfNessesscary() {
    if (widget.typeEditable) {
      return _buildFieldTypeSelectionChips();
    } else {
      return Container();
    }
  }

  Widget _buildFieldTypeSelectionChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: ClampingScrollPhysics(),
      child: Row(
        children: FieldType.values
            .map((type) => _fieldTypeChipFromType(type))
            .toList(),
      ),
    );
  }

  Widget _fieldTypeChipFromType(FieldType type) {
    final label = getFieldTypeAsString(type, AppLocalizations.of(context));
    return Row(
      children: <Widget>[
        ChoiceChip(
          label: Text(label),
          selected: _type == type,
          onSelected: (value) {
            if (value) {
              setState(() {
                _type = type;
                _resetValue();
              });
            }
          },
        ),
        SizedBox(width: 8.0)
      ],
    );
  }

  void _resetValue() {
    switch (_type) {
      case FieldType.amount:
        _value = 0;
        break;
      case FieldType.date:
        _value = DateTime.now();
        break;
      case FieldType.image:
        _value = "";
        break;
      case FieldType.text:
        _value = "";
        break;
      case FieldType.file:
        _value = "";
        break;
    }
  }

  Widget _buildTitleTypeBar() {
    if (widget.typeEditable) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  AppLocalizations.translateOf(
                      context, "field_card_click_description_to_edit"),
                  style: TextStyle(fontSize: 12),
                ),
                _buildTitle(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 4.0),
            child: Icon(Icons.dehaze),
          )
        ],
      );
    } else {
      return _buildTitle();
    }
  }

  Widget _buildTitle() {
    return TextField(
      enabled: widget.descriptionEditable,
      controller: _descriptionController,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText:
              AppLocalizations.translateOf(context, "field_input_description")),
    );
  }

  Widget _buildValueInput() {
    switch (_type) {
      case FieldType.amount:
        return Text("NOT SUPPORTED YET");
      case FieldType.date:
        return _buildValueDateInput();
      case FieldType.image:
        return Text("NOT SUPPORTED YET");
      case FieldType.text:
        return _buildValueTextInput();
      case FieldType.file:
        return Text("NOT SUPPORTED YET");
    }
  }

  Widget _buildValueTextInput() {
    return TextField(
      controller: TextEditingController(text: _value),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: AppLocalizations.translateOf(context, "field_input_value"),
      ),
      onChanged: (text) {
        _value = text;
        widget.onFieldChanged(_getFieldFromInputs());
      },
    );
  }

  Widget _buildValueDateInput() {
    final textChange = AppLocalizations.translateOf(context, "txt_change");
    return MaterialButton(
      child: Text(_dateFromValueAsReadableString() + " - " + textChange),
      onPressed: () async {
        final date = await _getDateTimeFromDatePicker();
        if (date != null) {
          _value = date;
          widget.onFieldChanged(_getFieldFromInputs());
        }
      },
    );
  }

  String _dateFromValueAsReadableString() {
    return DateFormat("EEEE dd.MM.yyyy").format(_value);
  }

  Future<DateTime> _getDateTimeFromDatePicker() async {
    final initalDate =
        _value is DateTime && _value != null ? _value : DateTime.now();
    return await showDatePicker(
        context: context,
        initialDate: initalDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
  }
}
