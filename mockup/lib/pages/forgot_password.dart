import 'package:flutter/material.dart';
import 'package:mockup/components/page_header.dart';
import 'package:mockup/components/nav_button.dart';
import 'package:mockup/pages/login.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);
  static String route = 'forgot_password';

  @override
  Widget build(BuildContext context) {
    return PageHeader(
      title: 'Forgot Password',
      body: Center(
        child: Column(
          children: [
            const Text('Forgot Password Placeholder'),
            NavBtn(
              label: 'Back',
              route: LoginDemo.route,
            ),
          ],
        ),
      ),
    );
  }
}
