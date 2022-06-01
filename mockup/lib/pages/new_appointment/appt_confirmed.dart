import 'package:flutter/material.dart';
import 'package:mockup/pages/my_appointments.dart';
import 'package:mockup/components/textbox.dart';

import '../../components/nav_button.dart';

class AppointmentConfirmed extends StatelessWidget {
  const AppointmentConfirmed({Key? key}) : super(key: key);
  static String route = 'appt_confirmed';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Road Test'),
      ),
      body: Center(
        child: Column(
          children: [
            FancyText(ftext: 'Appointment confirmed', style: Style.header),
            FancyText(ftext: 'Test Type: Written', style: Style.base),
            FancyText(ftext: 'City: Sackville', style: Style.base),
            FancyText(ftext: 'Date: June 03, 2022', style: Style.base),
            FancyText(ftext: 'Time: 01:30PM', style: Style.base),
            NavBtn(
              label: 'Back',
              route: MyAppointments.route,
            ),
          ],
        ),
      ),
    );
  }
}
