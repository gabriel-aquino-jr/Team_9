import 'package:flutter/material.dart';
import 'package:mockup/components/calendar.dart';
import 'package:mockup/components/nav_button.dart';
import 'package:mockup/pages/new_appointment/appt_confirmed.dart';
import 'package:mockup/components/textbox.dart';
import 'package:mockup/pages/new_appointment/appt_type.dart';
import 'package:sqflite/sqlite_api.dart';
import '../../model/global.dart';

class AppointmentReview extends StatefulWidget {
  const AppointmentReview({Key? key}) : super(key: key);

  @override
  State<AppointmentReview> createState() => _AppointmentReviewState();
}

class _AppointmentReviewState extends State<AppointmentReview> {
  int scheduleId = 0;

  void _queryDatabase() {
    _queryGetScheduleID();
    _queryInsertAppointment();
  }

  void _queryGetScheduleID() async {
    dbhelper.database;
    List scheduleQuery;
    scheduleQuery = await dbhelper.queryGetScheduleID(AppointmentInfo.date,
        AppointmentInfo.time, AppointmentInfo.type, AppointmentInfo.city);
    scheduleId = scheduleQuery[0][0];
    setState(() {});
  }

  void _queryInsertAppointment() async {
    dbhelper.database;
    await dbhelper.insertAppointment(AppointmentInfo.customerId, scheduleId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            const FancyText(ftext: 'Review your choices:', style: Style.header),
            const SizedBox(
              height: 40,
            ),
            Wrap(
              direction: Axis.vertical,
              spacing: 20,
              children: [
                FancyText(
                    ftext: 'Test Type: ${AppointmentInfo.type}',
                    style: Style.base),
                FancyText(
                    ftext: 'City: ${AppointmentInfo.city}', style: Style.base),
                FancyText(
                    ftext: 'Date: ${AppointmentInfo.date}', style: Style.base),
                FancyText(
                    ftext: 'Time: ${AppointmentInfo.time}', style: Style.base),
              ],
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
        NavBtn(
          label: 'Submit',
          route: AppointmentConfirmed.route,
          callback: _queryDatabase,
        ),
      ],
    );
  }
}
