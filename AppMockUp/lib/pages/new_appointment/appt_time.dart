import 'package:flutter/material.dart';
import 'package:mockup/components/calendar.dart';
import 'package:mockup/components/nav_button.dart';
import 'package:mockup/components/textbox.dart';
import 'package:mockup/model/schedule_model.dart';

class AppointmentTime extends StatefulWidget {
  const AppointmentTime({Key? key}) : super(key: key);

  //HomePage({this.title});
  @override
  State<AppointmentTime> createState() => _AppointmentTimeState();
}

enum TimeAvailable { at830AM, at1030AM, at100PM, at300PM, at0300PM }

class _AppointmentTimeState extends State<AppointmentTime> {
  TimeAvailable? _character = TimeAvailable.at830AM;

  List times = [];
  void _queryAllEvents() async {
    List<Schedules> _schedules = [];
    dbhelper.database;
    final allRows = await dbhelper.queryAllRows("schedules");
    debugPrint('query all employee rows:');
    for (var row in allRows) {
      _schedules.add(Schedules.fromMap(row));
    }

    _schedules.forEach((row) {
      if (row.date == "2022-06-10") {
        times.add(row.time);
      }
    });
    print('times:' + times.toString());

    setState(() {});
    allRows.forEach(print);
  }

  @override
  void initState() {
    super.initState();
    _queryAllEvents();
    //_steps.add(_lastQualificationStep());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const FancyText(ftext: 'Choose Time', style: Style.header),
        Visibility(
          visible: (times.contains('08:30:00')),
          child: ListTile(
            title: const Text('8:30 AM'),
            leading: Radio<TimeAvailable>(
              value: TimeAvailable.at830AM,
              groupValue: _character,
              onChanged: (TimeAvailable? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
        ),
        Visibility(
          visible: (times.contains('10:30:00')),
          child: ListTile(
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
        ),
        Visibility(
          visible: (times.contains('13:30:00')),
          child: ListTile(
            title: const Text('1:00 PM'),
            leading: Radio<TimeAvailable>(
              value: TimeAvailable.at100PM,
              groupValue: _character,
              onChanged: (TimeAvailable? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
        ),
        Visibility(
          visible: (times.contains('15:00:00')),
          child: ListTile(
            title: const Text('3:00 PM'),
            leading: Radio<TimeAvailable>(
              value: TimeAvailable.at300PM,
              groupValue: _character,
              onChanged: (TimeAvailable? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
