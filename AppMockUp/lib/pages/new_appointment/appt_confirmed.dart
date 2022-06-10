import 'package:flutter/material.dart';
import 'package:mockup/components/page_header.dart';
import 'package:mockup/model/global.dart';
import 'package:mockup/pages/my_appointments.dart';
import 'package:mockup/components/textbox.dart';

import '../../components/nav_button.dart';

class AppointmentConfirmed extends StatefulWidget {
  const AppointmentConfirmed({Key? key}) : super(key: key);
  static String route = 'appt_confirmed';

  @override
  State<AppointmentConfirmed> createState() => _AppointmentConfirmedState();
}

class _AppointmentConfirmedState extends State<AppointmentConfirmed> {
  @override
  void dispose() {
    super.dispose();
    AppointmentInfo.city = "";
    AppointmentInfo.date = "";
    AppointmentInfo.time = "";
    AppointmentInfo.type = "";
  }

  @override
  Widget build(BuildContext context) {
    return PageHeader(
      title: "Appointment Confirmed!",
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 300,
              child: FancyText(
                  ftext:
                      '${AppointmentInfo.customerName}, your appointment is confirmed!',
                  style: Style.header),
            ),
            const SizedBox(
              height: 20,
            ),
            Wrap(
              direction: Axis.vertical,
              spacing: 20,
              children: [
                FancyText(
                    ftext: 'Test Type: ${AppointmentInfo.type}',
                    style: Style.base),
                FancyText(
                    ftext: 'City: ${AppointmentInfo.city}', style: Style.base),
                FancyText(
                    ftext: 'Date: ${AppointmentInfo.date}', style: Style.base),
                FancyText(
                    ftext: 'Time: ${AppointmentInfo.time}', style: Style.base),
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
