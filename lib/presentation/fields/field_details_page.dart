import 'package:cash_box/domain/core/enteties/fields/field.dart';
import 'package:cash_box/core/platform/entetie_converter.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:flutter/material.dart';

class FieldDetailsPage extends StatefulWidget {
  final Field field;
  final bool storageOnlySelectable;

  const FieldDetailsPage(
      {Key key, @required this.field, this.storageOnlySelectable = true})
      : super(key: key);

  @override
  _FieldDetailsPageState createState() => _FieldDetailsPageState();
}

class _FieldDetailsPageState extends State<FieldDetailsPage> {
  TextEditingController descriptionController = TextEditingController();
  String description;
  FieldType type;
  int currentStep;
  bool storageOnly;

  @override
  void initState() {
    super.initState();
    currentStep = 0;
    type = widget.field.type;
    storageOnly = widget.field.storageOnly;

    description = widget.field.description;
    descriptionController.text = description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(description == null || description.isEmpty
            ? AppLocalizations.translateOf(context, "unnamed")
            : description),
      ),
      body: Stepper(
        currentStep: currentStep,
        type: StepperType.vertical,
        steps: steps,
        onStepContinue: () {
          if (currentStep != steps.length - 1) {
            setState(() => currentStep++);
          } else {
            Navigator.of(context).pop(getFieldOfValues());
          }
        },
        onStepTapped: (value) {
          setState(() => currentStep = value);
        },
        onStepCancel: () {
          if (currentStep != 0) {
            setState(() => currentStep--);
          } else {
            Navigator.pop(context);
          }
        },
        controlsBuilder: (context, {onStepCancel, onStepContinue}) {
          return Row(
            children: <Widget>[
              OutlineButton(
                onPressed: onStepContinue,
                child: Text(
                  AppLocalizations.translateOf(context, "btn_next"),
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
              SizedBox(width: 16.0),
              MaterialButton(
                onPressed: onStepCancel,
                child: Text(AppLocalizations.translateOf(context, "btn_back")),
              )
            ],
          );
        },
      ),
    );
  }

  List<Step> get steps {
    if(widget.storageOnlySelectable){
      return [
        _buildTypeStep(),
        _buildTitleStep(),
        _buildUsageStep(),
      ];
    } else {
      return [
        _buildTypeStep(),
        _buildTitleStep(),
      ];
    }
  }

  Step _buildTypeStep(){
    return Step(
      title: Text(AppLocalizations.translateOf(context, "txt_type")),
      subtitle: Text(AppLocalizations.translateOf(
          context, "txt_field_details_page_type_description")),
      content: _buildTypeSelection(),
      isActive: currentStep == 0,
      state: currentStep >= 0 && type != null
          ? StepState.complete
          : StepState.indexed,
    );
  }

  Step _buildTitleStep(){
    return Step(
      title: Text(AppLocalizations.translateOf(context, "txt_title")),
      subtitle: Text(AppLocalizations.translateOf(
          context, "txt_field_details_page_title_description")),
      content: _buildDescriptionTextField(),
      isActive: currentStep == 1,
      state: currentStep >= 1 && description != null
          ? StepState.complete
          : StepState.indexed,
    );
  }

  Step _buildUsageStep(){
    return Step(
      title: Text(AppLocalizations.translateOf(context, "txt_usage")),
      subtitle: Text(AppLocalizations.translateOf(
          context, "txt_field_details_page_usage_description")),
      content: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: _buildUsageCheckbox(),
      ),
      isActive: currentStep == 2,
      state: currentStep >= 2 && storageOnly != null
          ? StepState.complete
          : StepState.indexed,
    );
  }

  Widget _buildTypeSelection() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(color: Colors.grey)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<FieldType>(
            isExpanded: true,
            items: FieldType.values.map((e) {
              return DropdownMenuItem<FieldType>(
                value: e,
                child:
                    Text(getFieldTypeAsString(e, AppLocalizations.of(context))),
              );
            }).toList(),
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
            onChanged: (value) => setState(() => type = value),
            value: type,
          ),
        ),
      ),
    );
  }

  Widget _buildDescriptionTextField() {
    return TextField(
      controller: descriptionController,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: AppLocalizations.translateOf(context, "txt_title")),
      onChanged: (value) => setState(() => description = value),
    );
  }

  Widget _buildUsageCheckbox() {
    return CheckboxListTile(
      title:
          Text(AppLocalizations.translateOf(context, "txt_use_as_information")),
      subtitle: Text(
        AppLocalizations.translateOf(
            context, "txt_use_as_information_description"),
      ),
      value: storageOnly,
      onChanged: (value) => setState(() => storageOnly = value),
    );
  }

  Field getFieldOfValues() {
    return Field(widget.field.id,
        description: description,
        storageOnly: storageOnly,
        type: type,
        value: null);
  }
}
