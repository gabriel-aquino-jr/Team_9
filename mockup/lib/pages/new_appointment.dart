import 'package:flutter/material.dart';
import 'package:mockup/components/page_header.dart';
import 'package:mockup/components/tabs.dart';
import 'package:mockup/pages/new_appointment/appt_city.dart';
import 'package:mockup/pages/new_appointment/appt_date.dart';
import 'package:mockup/pages/new_appointment/appt_review.dart';
import 'package:mockup/pages/new_appointment/appt_time.dart';
import 'package:mockup/pages/new_appointment/appt_type.dart';

class NewAppointment extends StatefulWidget {
  static String route = 'New Road Test';

  const NewAppointment({Key? key}) : super(key: key);

  @override
  _NewAppointmentState createState() => _NewAppointmentState();
}

class _NewAppointmentState extends State<NewAppointment> {
  @override
  Widget build(BuildContext context) {
    return PageHeader(
      title: 'New appointment',
      body: Tabs(
        children: <TabInfo>[
          TabInfo(
            tabLabel: const Tab(text: 'Type'),
            child: const AppointmentType(),
          ),
          TabInfo(
            tabLabel: const Tab(text: 'City'),
            child: const AppointmentCity(),
          ),
          TabInfo(
            tabLabel: const Tab(text: 'Date'),
            child: const AppointmentDate(),
          ),
          TabInfo(
            tabLabel: const Tab(text: 'Time'),
            child: const AppointmentTime(),
          ),
          TabInfo(
            tabLabel: const Tab(text: 'Review'),
            child: const AppointmentReview(),
          ),
        ],
      ),
    );
  }
}
