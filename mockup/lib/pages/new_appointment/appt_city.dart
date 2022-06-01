import 'package:flutter/material.dart';
import 'package:mockup/components/nav_button.dart';
import 'package:mockup/components/textbox.dart';

class AppointmentCity extends StatefulWidget {
  const AppointmentCity({Key? key}) : super(key: key);

  //HomePage({this.title});
  @override
  State<AppointmentCity> createState() => _AppointmentCityState();
}

enum TimeAvailable { moncton, sackville, bathurst, edmunston, woodstock }

class _AppointmentCityState extends State<AppointmentCity> {
  TimeAvailable? _character = TimeAvailable.moncton;

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
<<<<<<< Updated upstream
    return Text('Choose the City:');
=======
    return Column(
      children: <Widget>[
        const FancyText(ftext: 'Choose City', style: Style.header),
        ListTile(
          title: const Text('Moncton'),
          leading: Radio<TimeAvailable>(
            value: TimeAvailable.moncton,
            groupValue: _character,
            onChanged: (TimeAvailable? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Sackville'),
          leading: Radio<TimeAvailable>(
            value: TimeAvailable.sackville,
            groupValue: _character,
            onChanged: (TimeAvailable? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Bathrust'),
          leading: Radio<TimeAvailable>(
            value: TimeAvailable.bathurst,
            groupValue: _character,
            onChanged: (TimeAvailable? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Woodstock'),
          leading: Radio<TimeAvailable>(
            value: TimeAvailable.woodstock,
            groupValue: _character,
            onChanged: (TimeAvailable? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Edmundston'),
          leading: Radio<TimeAvailable>(
            value: TimeAvailable.edmunston,
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
>>>>>>> Stashed changes
  }
}
