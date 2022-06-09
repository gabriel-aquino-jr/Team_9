import 'package:flutter/material.dart';
import 'package:mockup/components/nav_button.dart';
import 'package:mockup/components/textbox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/global.dart';

class AppointmentTime extends StatefulWidget {
  const AppointmentTime({Key? key}) : super(key: key);

  //HomePage({this.title});
  @override
  State<AppointmentTime> createState() => _AppointmentTimeState();
}

enum TimeAvailable { at1030AM, at1100AM, at0100PM, at0130PM, at0300PM }

class _AppointmentTimeState extends State<AppointmentTime> {
  TimeAvailable? _character = TimeAvailable.at1030AM;
  String time = "";

  getValueFromtxt() {
    if (_character == TimeAvailable.at0100PM) {
      time = "01:00PM";
    } else if (_character == TimeAvailable.at0130PM) {
      time = "01:30PM";
    } else if (_character == TimeAvailable.at1030AM) {
      time = "10:30AM";
    } else if (_character == TimeAvailable.at1100AM) {
      time = "11:00AM";
    } else {
      time = "03:00PM";
    }
    AppointmentInfo.time = time;
  }
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
        const FancyText(ftext: 'Choose Time', style: Style.header),
        ListTile(
          title: const Text('10:30 AM'),
          leading: Radio<TimeAvailable>(
            value: TimeAvailable.at1030AM,
            groupValue: _character,
            onChanged: (TimeAvailable? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('11:00 AM'),
          leading: Radio<TimeAvailable>(
            value: TimeAvailable.at1100AM,
            groupValue: _character,
            onChanged: (TimeAvailable? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('01:00 PM'),
          leading: Radio<TimeAvailable>(
            value: TimeAvailable.at0100PM,
            groupValue: _character,
            onChanged: (TimeAvailable? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('01:30 PM'),
          leading: Radio<TimeAvailable>(
            value: TimeAvailable.at0130PM,
            groupValue: _character,
            onChanged: (TimeAvailable? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('03:00 PM'),
          leading: Radio<TimeAvailable>(
            value: TimeAvailable.at0300PM,
            groupValue: _character,
            onChanged: (TimeAvailable? value) {
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
