import 'package:flutter/material.dart';
import 'package:mockup/components/nav_button.dart';
import 'package:mockup/components/textbox.dart';
import 'package:mockup/pages/new_appointment/appt_confirmed.dart';

class AppontmentReview extends StatelessWidget {
  const AppontmentReview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: const [
            FancyText(ftext: 'Review your choices:', style: Style.header),
            FancyText(ftext: 'Test Type: Written', style: Style.base),
            FancyText(ftext: 'City: Sackville', style: Style.base),
            FancyText(ftext: 'Date: June 03, 2022', style: Style.base),
            FancyText(ftext: 'Time: 01:30PM', style: Style.base),
          ],
        ),
        NavBtn(label: 'Submit', route: AppointmentConfirmed.route),
      ],
    );
  }
}
