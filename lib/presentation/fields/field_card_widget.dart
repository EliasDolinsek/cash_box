import 'package:cash_box/app/accounts_bloc/accounts_bloc.dart';
import 'package:cash_box/app/accounts_bloc/accounts_state.dart';
import 'package:cash_box/app/injection.dart';
import 'package:cash_box/core/platform/entetie_converter.dart';
import 'package:cash_box/domain/account/enteties/currencies.dart';
import 'package:cash_box/domain/core/enteties/fields/field.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/settings/dialogs/delete_dialog.dart';
import 'package:cash_box/presentation/widgets/content_card_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cash_box/core/platform/input_converter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class FieldDetailWidget extends StatelessWidget {
  final Field field;
  final Function onDelete;
  final Function onTap;

  const FieldDetailWidget(this.field, {Key key, this.onDelete, this.onTap})
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
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: onDelete,
      ),
    );
  }
}

class FieldInputWidget extends StatefulWidget {
  final Field field;
  final Function(Field field) onChanged;

  const FieldInputWidget({Key key, this.field, this.onChanged})
      : super(key: key);

  @override
  _FieldInputWidgetState createState() => _FieldInputWidgetState();
}

class _FieldInputWidgetState extends State<FieldInputWidget> {

  TextEditingController textController;

  @override
  void initState() {
    super.initState();
    if(widget.field.type == FieldType.text){
      textController = TextEditingController(text: widget.field.value ?? "");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.field.description,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        SizedBox(height: 8.0),
        _buildValueInput(context),
      ],
    );
  }

  Widget _buildValueInput(BuildContext context) {
    switch (widget.field.type) {
      case FieldType.amount:
        return _buildValueAmountInput(context);
      case FieldType.date:
        return _buildValueDateInput(context);
      case FieldType.image:
        return Text("NOT SUPPORTED YET");
      case FieldType.text:
        return _buildValueTextInput(context);
      case FieldType.file:
        return Text("NOT SUPPORTED YET");
      default:
        return Container();
    }
  }

  Widget _buildValueAmountInput(BuildContext context) {
    return BlocBuilder(
      bloc: sl<AccountsBloc>(),
      builder: (context, state) {
        var currencySymbol = "";
        if (state is AccountAvailableState && state.account != null) {
          currencySymbol = currencySymbolFromCode(state.account.currencyCode);
        }

        return TextField(
          controller: _getMoneyController(currencySymbol),
          keyboardType:
              TextInputType.numberWithOptions(signed: true, decimal: true),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText:
                AppLocalizations.translateOf(context, "field_input_value"),
          ),
        );
      },
    );
  }

  MoneyMaskedTextController _getMoneyController(String currencySymbol) {
    final controller = MoneyMaskedTextController(
        decimalSeparator: ",",
        thousandSeparator: ".",
        initialValue: widget.field.value ?? 0,
        rightSymbol: currencySymbol);

    controller.addListener(() {
      widget.onChanged(_getFieldFromValue(controller.numberValue));
    });

    return controller;
  }

  Widget _buildValueTextInput(BuildContext context) {
    return TextField(
      controller: textController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: AppLocalizations.translateOf(context, "field_input_value"),
      ),
      onChanged: (value) => widget.onChanged(_getFieldFromValue(value)),
    );
  }

  Widget _buildValueDateInput(BuildContext context) {
    final textChange = AppLocalizations.translateOf(context, "btn_change");
    return Center(
      child: MaterialButton(
        child: Text(
          _getDateForDateInput(context) + " - " + textChange,
        ),
        onPressed: () async {
          final date = await _getDateTimeFromDatePicker(context);
          if (date != null) {
            widget.onChanged(_getFieldFromValue(date));
          }
        },
      ),
    );
  }

  String _getDateForDateInput(BuildContext context) {
    if (widget.field.value != null) {
      final usableDate = widget.field.value is Timestamp ? widget.field.value.toDate() : widget.field.value;
      return getDateAsReadableDate(usableDate);
    } else {
      return AppLocalizations.translateOf(context, "txt_no_date_selected");
    }
  }

  Future<DateTime> _getDateTimeFromDatePicker(BuildContext context) async {
    final initialDate = widget.field.value is DateTime && widget.field.value != null
        ? widget.field.value
        : DateTime.now();

    return await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
  }

  Field _getFieldFromValue(dynamic value) {
    return Field(
      widget.field.id,
      type: widget.field.type,
      description: widget.field.description,
      value: value,
      storageOnly: widget.field.storageOnly,
    );
  }
}
