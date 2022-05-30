import 'package:flutter/material.dart';
import 'package:mockup/components/nav_button.dart';
import 'package:mockup/pages/new_appointment/appt_confirmed.dart';

class AppontmentReview extends StatelessWidget {
  const AppontmentReview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Review your choices:'),
        NavBtn(label: 'Submit', route: AppointmentConfirmed.route),
      ],
    );
  }
}
