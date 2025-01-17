import 'dart:io' show Platform;

import 'package:cash_box/domain/core/enteties/fields/field.dart';
import 'package:cash_box/core/platform/entetie_converter.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/base/screen_type_layout.dart';
import 'package:cash_box/presentation/base/sizing_information.dart';
import 'package:cash_box/presentation/base/width_constrained_widget.dart';
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, getFieldOfValues());
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            description == null || description.isEmpty
                ? AppLocalizations.translateOf(context, "unnamed")
                : description,
          ),
          leading: IconButton(
            icon: Icon(
              Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.pop(context, getFieldOfValues());
            },
          ),
        ),
        body: ScreenTypeBuilder(
          builder: (screenType) {
            final stepperType = screenType != DeviceScreenType.mobile
                ? StepperType.horizontal
                : StepperType.vertical;

            return Stepper(
              currentStep: currentStep,
              type: stepperType,
              steps: steps,
              onStepContinue: () {
                if (currentStep != steps.length - 1) {
                  setState(() => currentStep++);
                } else {
                  Navigator.pop(context, getFieldOfValues());
                }
              },
              onStepTapped: (value) {
                setState(() => currentStep = value);
              },
              onStepCancel: () {
                if (currentStep != 0) {
                  setState(() => currentStep--);
                } else {
                  Navigator.pop(context, getFieldOfValues());
                }
              },
              controlsBuilder: _buildControls,
            );
          },
        ),
      ),
    );
  }

  Widget _buildControls(context, {onStepCancel, onStepContinue}) {
    return Center(
      child: WidthConstrainedWidget(
        child: Row(
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
        ),
      ),
    );
  }

  List<Step> get steps {
    if (widget.storageOnlySelectable) {
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

  Widget _buildStepContentContainer({@required Widget child}) {
    return Align(
      alignment: Alignment.topCenter,
      child: WidthConstrainedWidget(
        child: child,
      ),
    );
  }

  Step _buildTypeStep() {
    return Step(
      title: Text(AppLocalizations.translateOf(context, "txt_type")),
      subtitle: Text(AppLocalizations.translateOf(
          context, "txt_field_details_page_type_description")),
      content: _buildStepContentContainer(
        child: _buildTypeSelection(),
      ),
      isActive: currentStep == 0,
      state: currentStep >= 0 && type != null
          ? StepState.complete
          : StepState.indexed,
    );
  }

  Step _buildTitleStep() {
    return Step(
      title: Text(AppLocalizations.translateOf(context, "txt_title")),
      subtitle: Text(AppLocalizations.translateOf(
          context, "txt_field_details_page_title_description")),
      content: _buildStepContentContainer(
        child: _buildDescriptionTextField(),
      ),
      isActive: currentStep == 1,
      state: currentStep >= 1 && description != null
          ? StepState.complete
          : StepState.indexed,
    );
  }

  Step _buildUsageStep() {
    return Step(
      title: Text(AppLocalizations.translateOf(context, "txt_usage")),
      subtitle: Text(AppLocalizations.translateOf(
          context, "txt_field_details_page_usage_description")),
      content: _buildStepContentContainer(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: _buildUsageCheckbox(),
        ),
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
    return Column(
      children: <Widget>[
        CheckboxListTile(
          title: Text(AppLocalizations.translateOf(
              context, "txt_use_as_information_only")),
          subtitle: Text(
            AppLocalizations.translateOf(
                context, "txt_use_as_information_only_description"),
          ),
          value: storageOnly || Field.isFieldTypeStorageOnly(type),
          onChanged: !Field.isFieldTypeStorageOnly(type)
              ? _getOnChangedForUsageCheckbox
              : null,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8.0),
          child: _getNotAvailableInformationForUsageCheckboxIfNecessary(),
        )
      ],
    );
  }

  Field getFieldOfValues() {
    return Field(
      widget.field.id,
      description: description,
      storageOnly: storageOnly,
      type: type,
      value: null,
    );
  }

  void _getOnChangedForUsageCheckbox(bool value) =>
      setState(() => storageOnly = value);

  Widget _getNotAvailableInformationForUsageCheckboxIfNecessary() {
    if (type == FieldType.amount || type == FieldType.text) {
      return Container();
    } else {
      final localizations = AppLocalizations.of(context);
      return Row(
        children: <Widget>[
          Icon(
            Icons.info_outline,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(width: 8.0),
          Flexible(
            child: Text(
              "The field type ${getFieldTypeAsString(type, localizations)} is only available as information",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          )
        ],
      );
    }
  }
}
