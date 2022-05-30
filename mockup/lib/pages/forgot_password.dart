import 'package:flutter/material.dart';
import 'package:mockup/components/nav_button.dart';
import 'package:mockup/pages/login.dart';

class forgot_password extends StatelessWidget {
  const forgot_password({Key? key}) : super(key: key);
  static String route = 'forgot_password';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('Forgot Password Placeholder'),
            NavBtn(
              label: 'Home',
              route: LoginDemo.route,
            ),
          ],
        ),
      ),
    );
  }
}
