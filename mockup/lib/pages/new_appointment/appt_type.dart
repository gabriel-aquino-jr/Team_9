import 'package:flutter/material.dart';
import 'package:mockup/components/nav_button.dart';
import 'package:mockup/components/textbox.dart';
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

enum SingingCharacter { lafayette, jefferson }

class _AppointmentTypeState extends State<AppointmentType> {
  SingingCharacter? _character = SingingCharacter.lafayette;

  // List<Step> get _steps => <Step>[_lastQualificationStep()];
  // int _currentStep = 0;
  // bool _isStepsCompleted = false;

  @override
  void initState() {
    super.initState();
    //_steps.add(_lastQualificationStep());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FancyText(ftext: 'Choose Appointment Type', style: Style.header),
        ListTile(
          title: const Text('Lafayette'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.lafayette,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Thomas Jefferson'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.jefferson,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
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
