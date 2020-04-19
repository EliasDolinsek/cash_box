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
  bool _storageOnly;

  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _type = widget.field.type;
    _description = widget.field.description;
    _value = widget.field.value;
    _storageOnly = widget.field.storageOnly;
    _initValue();

    _descriptionController.text = _description;
    _descriptionController.addListener(() => _notifyUpdated());
  }

  void _notifyUpdated() {
    _description = _descriptionController.text;
    widget.onFieldChanged(_getFieldFromInputs());
  }

  void _initValue() {
    if (_type == FieldType.date) {
      if (_value is Timestamp) {
        _value = _value.toDate();
      }
    } else if (_type == FieldType.text && _value == null) {
      _value = "";
    } else if (_type == FieldType.amount && _value == null) {
      _value = 0.0;
    }
  }

  Field _getFieldFromInputs() {
    return Field(
      widget.field.id,
      type: _type,
      description: _description,
      value: _value,
      storageOnly: _storageOnly,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TitledListContentCardWidget(
      title: _buildTitleTypeBar(),
      items: <Widget>[
        _buildValueInput(),
        SizedBox(height: 8.0),
        _buildFieldTypeSelectionChipsIfNessesscary(),
        SizedBox(height: 8.0),
        _buildBottomBar()
      ],
    );
  }

  Widget _buildBottomBar() {
    if (widget.typeEditable &&
        (_type == FieldType.amount || _type == FieldType.text)) {
      return Row(
        children: <Widget>[
          _checkAndBuildDeleteButton(),
          _buildInformationOnlySelection(),
        ],
      );
    } else {
      return _checkAndBuildDeleteButton();
    }
  }

  Widget _buildInformationOnlySelection() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          items: _buildDropdownButtons(),
          onChanged: (value) {
            setState(() => _storageOnly = value);
            _notifyUpdated();
          },
          value: _storageOnly,
        ),
      ),
    );
  }

  List<DropdownMenuItem> _buildDropdownButtons() {
    return [
      _buildInformationalOnlyDropdownItem(),
      _buildNonInformationalOnlyDropdownItem(),
    ];
  }

  Widget _buildNonInformationalOnlyDropdownItem() {
    if (_type == FieldType.text) {
      return _buildUseAsTitleDropdownItem();
    } else if (_type == FieldType.amount) {
      return _buildUseAsAmountDropdownItem();
    } else {
      return Container();
    }
  }

  Widget _buildUseAsAmountDropdownItem() {
    return _buildDropdownItemForChild(
        child: ListTile(
          title: Text(
            AppLocalizations.translateOf(context, "txt_use_as_amount"),
          ),
          subtitle: Text(
            AppLocalizations.translateOf(
                context, "txt_use_as_amount_description"),
          ),
        ),
        value: false);
  }

  Widget _buildUseAsTitleDropdownItem() {
    return _buildDropdownItemForChild(
        child: ListTile(
          title:
              Text(AppLocalizations.translateOf(context, "txt_use_as_title")),
        ),
        value: false);
  }

  DropdownMenuItem _buildInformationalOnlyDropdownItem() {
    return _buildDropdownItemForChild(
        child: ListTile(
          title: Text(
            AppLocalizations.translateOf(context, "txt_information_only"),
          ),
        ),
        value: true);
  }

  Widget _buildDropdownItemForChild({Widget child, dynamic value}) {
    return DropdownMenuItem(
      value: value,
      child: Container(
        width: 200,
        height: 60,
        child: child,
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
    if (result != null && result) {
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

              _notifyUpdated();
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
        _value = 0.0;
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
        return _buildValueAmountInput();
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

  Widget _buildValueAmountInput() {
    return TextField(
      controller: _getMoneyController(),
      keyboardType:
          TextInputType.numberWithOptions(signed: true, decimal: true),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: AppLocalizations.translateOf(context, "field_input_value"),
      ),
    );
  }

  MoneyMaskedTextController _getMoneyController() {
    final controller = MoneyMaskedTextController(
        decimalSeparator: ",",
        thousandSeparator: ".",
        initialValue: _value,
        rightSymbol: "€");

    controller.addListener(() {
      _value = controller.numberValue;
      widget.onFieldChanged(_getFieldFromInputs());
    });

    return controller;
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
    final textChange = AppLocalizations.translateOf(context, "btn_change");
    return MaterialButton(
      child: Text(InputConverter.dateFromValueAsReadableString(_value) +
          " - " +
          textChange),
      onPressed: () async {
        final date = await _getDateTimeFromDatePicker();
        if (date != null) {
          _value = date;
          widget.onFieldChanged(_getFieldFromInputs());
        }
      },
    );
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
