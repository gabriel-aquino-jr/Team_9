import 'package:flutter/material.dart';
import 'package:mockup/components/nav_button.dart';
import 'package:mockup/components/textbox.dart';
import 'package:mockup/database/db_helper.dart';
import '../../model/global.dart';
import 'package:mockup/utilities/palette.dart';
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
  final dbHelper = DBHelper.instance;

  List<String> _cities = [];

  // List<Step> get _steps => <Step>[_lastQualificationStep()];
  // int _currentStep = 0;
  // bool _isStepsCompleted = false;

  void _queryCitiesAvailable() async {
    dbHelper.database;
    final allCities = await dbHelper.queryCitiesAvailable();
    debugPrint('query cities with schedule available');
    _cities.clear(); // clearing cities
    for (var row in allCities) {
      _cities.add(row['location'].toString());
    }
    (AppointmentInfo.city == "")
        ? selectedIndex = -1
        : selectedIndex =
            _cities.indexWhere((element) => element == AppointmentInfo.city);

    setState(() {});
    allCities.forEach(print);
  }

  @override
  void initState() {
    super.initState();
    _queryCitiesAvailable();
  }

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _cities.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(_cities[index]),
            tileColor: selectedIndex == index ? Palette.medGreen : null,
            onTap: () {
              setState(() {
                selectedIndex = index;
                AppointmentInfo.city = _cities[index];
              });
            },
          ),
        );
      },
    );
  }
}
