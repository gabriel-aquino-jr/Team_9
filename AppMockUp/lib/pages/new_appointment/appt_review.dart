import 'package:flutter/material.dart';
import 'package:mockup/components/nav_button.dart';
import 'package:mockup/pages/new_appointment/appt_confirmed.dart';
import 'package:mockup/components/textbox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/global.dart';

class AppointmentReview extends StatelessWidget {
  const AppointmentReview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            const FancyText(ftext: 'Review your choices:', style: Style.header),
            SizedBox(
              height: 40,
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
            SizedBox(
              height: 40,
            )
          ],
        ),
        NavBtn(label: 'Submit', route: AppointmentConfirmed.route),
      ],
    );
  }
}
