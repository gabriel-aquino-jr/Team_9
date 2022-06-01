import 'package:flutter/material.dart';
import 'package:mockup/components/calendar.dart';
import 'package:mockup/components/textbox.dart';

class AppointmentDate extends StatelessWidget {
  const AppointmentDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        FancyText(
          ftext: 'Choose your date:',
          style: Style.header,
        ),
        Expanded(
            child: SizedBox(
          height: 100.0,
          child: Calendar(),
        )),
      ],
    );
  }
}
