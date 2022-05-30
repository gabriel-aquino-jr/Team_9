import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:mockup/components/nav_button.dart';
import 'package:mockup/pages/new_appointment.dart';
import 'package:mockup/pages/view_Appointment.dart';

/*
void main() {
  runApp(MyApp());
}
*/
class MyAppointments extends StatefulWidget {
  const MyAppointments({Key? key, required this.title}) : super(key: key);
  static String route = 'MyAppointments';
  final String title;

  @override
  _MyAppointmentsState createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<MyAppointments> {
  // The following list is already sorted by id
  final List<Map> _appointments = [
    {'date': '06/01/2022', 'time': '1:30PM', 'type': 'Written'},
    {'date': '06/23/2022', 'time': '3:45PM', 'type': 'Road'},
  ];
  List<bool> _selected = [];
  @override
  void initState() {
    super.initState();
    _selected = List<bool>.generate(_appointments.length, (int index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Appointments'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Column(
              children: [
                _createDataTable(),
                NavBtn(label: 'New', route: NewAppointment.route)
              ],
            )
          ],
        ),
      ),
    );
  }

  DataTable _createDataTable() {
    return DataTable(columns: _createColumns(), rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(label: Text('Date')),
      const DataColumn(label: Text('Time')),
      const DataColumn(label: Text('Type'))
    ];
  }

  List<DataRow> _createRows() {
    return _appointments
        .mapIndexed((index, appointment) => DataRow(
              cells: [
                DataCell(Text(appointment['date'])),
                DataCell(Text(appointment['time'])),
                DataCell(Text(appointment['type']))
              ],
              selected: _selected[index],
              onSelectChanged: (bool? selected) {
                setState(() {
                  _selected[index] = selected!;
                });
              },
              onLongPress: () {
                Navigator.pushNamed(context, ViewAppointments.route);
              },
            ))
        .toList();
  }
}
