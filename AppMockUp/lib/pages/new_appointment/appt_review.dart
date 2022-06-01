import 'package:flutter/material.dart';
import 'package:mockup/components/nav_button.dart';
import 'package:mockup/pages/new_appointment/appt_confirmed.dart';
import 'package:mockup/components/textbox.dart';

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
                const FancyText(ftext: 'Test Type: Written', style: Style.base),
                const FancyText(ftext: 'City: Sackville', style: Style.base),
                const FancyText(
                    ftext: 'Date: June 03, 2022', style: Style.base),
                const FancyText(ftext: 'Time: 01:30PM', style: Style.base),
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
