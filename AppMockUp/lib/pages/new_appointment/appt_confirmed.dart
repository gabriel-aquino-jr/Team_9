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
      title: "Your Road Test",
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 300,
              child: const FancyText(
                  ftext: 'Your Appointment is confirmed!', style: Style.header),
            ),
            const SizedBox(
              height: 20,
            ),
            Wrap(
              direction: Axis.vertical,
              spacing: 20,
              children: [
                const FancyText(ftext: 'Test Type: Written', style: Style.base),
                const FancyText(ftext: 'City: Sackville', style: Style.base),
                const FancyText(
                    ftext: 'Date: June 03, 2022', style: Style.base),
                const FancyText(ftext: 'Time: 01:30PM', style: Style.base),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
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
