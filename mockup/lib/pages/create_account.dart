import 'package:flutter/material.dart';
import 'package:mockup/components/page_header.dart';
import 'package:mockup/pages/login.dart';

import '../components/nav_button.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({Key? key}) : super(key: key);
  static String route = 'create_account';

  @override
  Widget build(BuildContext context) {
    return PageHeader(
      title: 'Create Account',
      body: Center(
        child: Column(
          children: [
            const Text('Create Account Placeholder'),
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
