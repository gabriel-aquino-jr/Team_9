import 'package:flutter/material.dart';
import 'package:mockup/components/page_header.dart';
import 'package:mockup/pages/my_appointments.dart';
import 'package:mockup/components/textbox.dart';

import '../../components/nav_button.dart';

class AppointmentConfirmed extends StatelessWidget {
  const AppointmentConfirmed({Key? key}) : super(key: key);
  static String route = 'appt_confirmed';

  @override
  Widget build(BuildContext context) {
    return PageHeader(
      title: "Road Test",
      body: Center(
        child: Column(
          children: [
            const FancyText(
                ftext: 'Your Appointment is confirmed!', style: Style.header),
            const FancyText(ftext: 'Test Type: Written', style: Style.base),
            const FancyText(ftext: 'City: Sackville', style: Style.base),
            const FancyText(ftext: 'Date: June 03, 2022', style: Style.base),
            const FancyText(ftext: 'Time: 01:30PM', style: Style.base),
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
