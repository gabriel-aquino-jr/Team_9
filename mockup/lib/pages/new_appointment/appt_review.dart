import 'package:flutter/material.dart';
import 'package:mockup/components/nav_button.dart';
import 'package:mockup/pages/new_appointment/appt_confirmed.dart';

class AppointmentReview extends StatelessWidget {
  const AppointmentReview({Key? key}) : super(key: key);

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
