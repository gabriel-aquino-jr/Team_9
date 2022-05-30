import 'package:flutter/material.dart';
import 'package:mockup/components/tabs.dart';
import 'package:mockup/pages/new_appointment/appt_city.dart';
import 'package:mockup/pages/new_appointment/appt_date.dart';
import 'package:mockup/pages/new_appointment/appt_review.dart';
import 'package:mockup/pages/new_appointment/appt_time.dart';
import 'package:mockup/pages/new_appointment/appt_type.dart';

class NewAppointment extends StatefulWidget {
  final title;
  static String route = 'New Road Test';

  const NewAppointment({Key? key, required this.title}) : super(key: key);

  @override
  _NewAppointmentState createState() => _NewAppointmentState();
}

class _NewAppointmentState extends State<NewAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Tabs(
        myTabs: <TabInfo>[
          TabInfo(
            tabLabel: const Tab(text: 'Type'),
            content: const AppointmentType(),
          ),
          TabInfo(
            tabLabel: const Tab(text: 'City'),
            content: AppontmentCity(),
          ),
          TabInfo(
            tabLabel: const Tab(text: 'Date'),
            content: AppontmentDate(),
          ),
          TabInfo(
            tabLabel: const Tab(text: 'Time'),
            content: AppontmentTime(),
          ),
          TabInfo(
            tabLabel: Tab(text: 'Review'),
            content: AppontmentReview(),
          ),
        ],
      ),
    );
  }
}
