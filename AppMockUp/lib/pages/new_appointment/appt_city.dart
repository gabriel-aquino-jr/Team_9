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

class AppointmentCity extends StatefulWidget {
  const AppointmentCity({Key? key}) : super(key: key);

  //HomePage({this.title});
  @override
  State<AppointmentCity> createState() => _AppointmentCityState();
}

enum Cities { moncton, sackville, bathurst, woodstock, edmundston }

class _AppointmentCityState extends State<AppointmentCity> {
  Cities? _character = Cities.moncton;

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
        const FancyText(ftext: 'Choose City', style: Style.header),
        ListTile(
          title: const Text('Moncton (Available)'),
          leading: Radio<Cities>(
            value: Cities.moncton,
            groupValue: _character,
            onChanged: (Cities? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Sackville (Not available)'),
          leading: Radio<Cities>(
            value: Cities.sackville,
            groupValue: _character,
            onChanged: (Cities? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Bathurst (Not available)'),
          leading: Radio<Cities>(
            value: Cities.bathurst,
            groupValue: _character,
            onChanged: (Cities? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Woodstock (Available)'),
          leading: Radio<Cities>(
            value: Cities.woodstock,
            groupValue: _character,
            onChanged: (Cities? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Edmundston (Available)'),
          leading: Radio<Cities>(
            value: Cities.edmundston,
            groupValue: _character,
            onChanged: (Cities? value) {
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
