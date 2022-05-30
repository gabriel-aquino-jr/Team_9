import 'package:flutter/material.dart';
import 'package:mockup/components/nav_button.dart';
import 'package:mockup/components/page_header.dart';
import 'package:mockup/pages/my_appointments.dart';

class ViewAppointments extends StatelessWidget {
  const ViewAppointments({Key? key}) : super(key: key);
  static String route = 'view_appointments';

  @override
  Widget build(BuildContext context) {
    return PageHeader(
      title: 'Appointment Details',
      body: Center(
        child: Column(
          children: [
            const Text('View Appointments Placeholder'),
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
