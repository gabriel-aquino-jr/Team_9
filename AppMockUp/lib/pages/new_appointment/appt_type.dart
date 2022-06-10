import 'package:flutter/material.dart';
import 'package:mockup/components/nav_button.dart';
import 'package:mockup/components/textbox.dart';
import 'package:mockup/utilities/palette.dart';
import '../../model/global.dart';

// source: https://stackoverflow.com/questions/60027498/flutter-radio-value-not-changing-in-stepper
/*
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
*/

class AppointmentType extends StatefulWidget {
  const AppointmentType({Key? key}) : super(key: key);

  //HomePage({this.title});
  @override
  State<AppointmentType> createState() => _AppointmentTypeState();
}

enum ApptType { written, road }

class _AppointmentTypeState extends State<AppointmentType> {
  ApptType? _character = ApptType.written;

  String getTextFromValue() {
    String type = "";
    (_character == ApptType.written) ? type = "Written" : type = "Road";
    return type;
  }

  ApptType getValueFromtxt() {
    ApptType type;
    (AppointmentInfo.type == "Written")
        ? type = ApptType.written
        : type = ApptType.road;
    return type;
  }
  // List<Step> get _steps => <Step>[_lastQualificationStep()];
  // int _currentStep = 0;
  // bool _isStepsCompleted = false;

  @override
  void initState() {
    super.initState();
    (AppointmentInfo.type == "")
        ? _character = null
        : _character = getValueFromtxt();
    //_steps.add(_lastQualificationStep());
  }

  @override
  void dispose() {
    AppointmentInfo.type = getTextFromValue();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const FancyText(ftext: 'Choose Appointment Type', style: Style.header),
        Container(
          child: Column(
            children: [
              ListTile(
                title: const Text('Written Test'),
                leading: Radio<ApptType>(
                  value: ApptType.written,
                  groupValue: _character,
                  onChanged: (ApptType? value) {
                    setState(() {
                      _character = value;
                      getValueFromtxt();
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Road Test'),
                leading: Radio<ApptType>(
                  value: ApptType.road,
                  groupValue: _character,
                  onChanged: (ApptType? value) {
                    setState(() {
                      _character = value;
                      getValueFromtxt();
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//   void onStepContinue() {
//     _currentStep + 1 != _steps.length
//         ? onStepTapped(_currentStep + 1)
//         : setState(() => _isStepsCompleted = true);
//   }

//   void onStepTapped(int step) => setState(() => _currentStep = step);

//   void onStepCancel() {
//     if (_currentStep > 0) {
//       onStepTapped(_currentStep - 1);
//     }
//   }

//   void setSelectRadioButton(int value, int groupValue) {
//     print('Radio Value: $value');
//     print('GroupValue before setState: $groupValue');
//     setState(() {
//       _qualificationRadioGroupValue = value;
//     });
//     print('GroupValue after setState: $groupValue');
//   }

//   int _qualificationRadioGroupValue = 0;

//   Step _lastQualificationStep() {
//     List<RadioModel> qualifitcationList = [
//       RadioModel(
//           title: 'Written test',
//           value: 0,
//           groupValue: _qualificationRadioGroupValue),
//       RadioModel(
//           title: 'Road test',
//           value: 1,
//           groupValue: _qualificationRadioGroupValue),
//     ];
//     return Step(
//       title: const Text('Select your appointment type'),
//       isActive: _currentStep == 0,
//       state: _currentStep == 0 ? StepState.editing : StepState.indexed,
//       content: Column(
//         children: qualifitcationList
//             .map(
//               (qualification) => RadioListTile<dynamic>(
//                 title: Text(qualification.title),
//                 value: qualification.value,
//                 groupValue: _qualificationRadioGroupValue,
//                 onChanged: (value) => setSelectRadioButton(
//                     int.parse(value.toString()), qualification.groupValue),
//               ),
//             )
//             .toList(),
//       ),
//     );
//   }
// }

// class RadioModel {
//   final title;
//   final value;
//   final groupValue;

//   RadioModel({this.title, this.value, this.groupValue});
// }
