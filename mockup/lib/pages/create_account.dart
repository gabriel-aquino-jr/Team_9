import 'package:flutter/material.dart';
import 'package:mockup/pages/my_appointments.dart';

import '../components/nav_button.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({Key? key}) : super(key: key);
  static String route = 'create_account';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('placeholder'),
      ),
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
