import 'package:flutter/material.dart';

import 'package:mockup/pages/new_appointment/appt_confirmed.dart';
import 'package:mockup/pages/create_account.dart';
import 'package:mockup/pages/forgot_password.dart';
import 'package:mockup/pages/login.dart';
import 'package:mockup/pages/my_appointments.dart';
import 'package:mockup/pages/new_appointment.dart';
import 'package:mockup/pages/view_appointment.dart';

import 'package:mockup/provider/button_provider.dart';
import 'package:mockup/utilities/palette.dart';
import 'package:mockup/utilities/typography.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
        // ButtonProvider(
        //   child:
        MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: LoginDemo.route,
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        LoginDemo.route: (context) => LoginDemo(),
        MyAppointments.route: (context) => const MyAppointments(),
        NewAppointment.route: (context) => const NewAppointment(),
        ForgotPassword.route: (context) => const ForgotPassword(),
        CreateAccount.route: (context) => const CreateAccount(),
        AppointmentConfirmed.route: (context) => const AppointmentConfirmed(),
        ViewAppointments.route: (context) => const ViewAppointments(),
        // home: LoginDemo(), // This doesn't work with Routes
      },
      theme: ThemeData(
        textTheme: TextTypography.textTheme,
        fontFamily: TextTypography.fontFamily,
        primarySwatch: Colors.amber,
        // primarySwatch: Palette.matDarkGreen,  // This is breaking
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        primaryColor: Palette.medGreen,
        primaryColorDark: Palette.darkGreen,
        primaryColorLight: Palette.lightGreen,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        backgroundColor: Colors.black,
      ),
    );
  }
}
