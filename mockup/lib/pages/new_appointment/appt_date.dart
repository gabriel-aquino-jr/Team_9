import 'package:flutter/material.dart';
import 'package:mockup/components/calendar.dart';

class AppointmentDate extends StatelessWidget {
  const AppointmentDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        Text('Choose your date:'),
        Expanded(
            child: SizedBox(
          height: 100.0,
          child: Calendar(),
        )),
      ],
    );
  }
}
