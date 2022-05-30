import 'package:flutter/material.dart';
import 'package:mockup/pages/home.dart';
import 'package:mockup/pages/login.dart';

import '../components/nav_button.dart';

class create_account extends StatelessWidget {
  const create_account({Key? key}) : super(key: key);
  static String route = 'create_account';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('Create Account Placeholder'),
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
