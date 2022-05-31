import 'package:flutter/material.dart';
import 'package:mockup/components/page_header.dart';
import 'package:mockup/pages/my_appointments.dart';

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
            const Text('Create Account Placeholder'),
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
