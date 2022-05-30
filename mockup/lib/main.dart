import 'package:flutter/material.dart';
import 'package:mockup/pages/create_account.dart';
import 'package:mockup/pages/forgot_password.dart';
import 'package:mockup/pages/login.dart';
import 'package:mockup/pages/my_appointments.dart';
import 'package:mockup/pages/new_appointment.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: LoginDemo.route,
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        LoginDemo.route: (context) => LoginDemo(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        MyAppointments.route: (context) => const MyAppointments(
              title: 'Welcome <userName>',
            ),
        NewAppointment.route: (context) => const NewAppointment(
              title: 'New Appointment',
            ),
        forgot_password.route: (context) => const forgot_password(),
        create_account.route: (context) => const create_account()
        // home: LoginDemo(), // This doesn't work with Routes
      },
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
    );
  }
}
