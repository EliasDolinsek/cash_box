import 'package:cash_box/domain/core/enteties/fields/field.dart';
import 'package:flutter/material.dart';

class FieldDetailsPage extends StatefulWidget {
  final Field field;

  const FieldDetailsPage({Key key, @required this.field}) : super(key: key);

  @override
  _FieldDetailsPageState createState() => _FieldDetailsPageState();
}

class _FieldDetailsPageState extends State<FieldDetailsPage> {
  int currentStep;

  @override
  void initState() {
    super.initState();
    currentStep = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stepper(
        currentStep: currentStep,
        type: StepperType.vertical,
        steps: steps,
        onStepContinue: () {
          setState(() {
            if (currentStep != steps.length - 1) {
              currentStep++;
            }
          });
        },
        onStepTapped: (value) {
          setState(() => currentStep = value);
        },
        onStepCancel: () {
          if (currentStep != 0) {
            setState(() => currentStep--);
          }
        },
        controlsBuilder: (context, {onStepCancel, onStepContinue}) {
          return Row(
            children: <Widget>[
              RaisedButton(
                onPressed: onStepContinue,
                child: Text(
                  "NEXT",
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(width: 16.0),
              MaterialButton(
                onPressed: onStepCancel,
                child: Text("BACK"),
              )
            ],
          );
        },
      ),
    );
  }

  List<Step> get steps => [
        Step(
          title: Text("Type"),
          subtitle: Text("What type of content should store?"),
          content: Text("Test"),
        ),
        Step(
          title: Text("Title"),
          subtitle: Text("What should this field store?"),
          content: Text("Test"),
        ),
        Step(
          title: Text("Usage"),
          subtitle: Text("Should this field be used as information only"),
          content: Text("Test"),
        ),
      ];
}
