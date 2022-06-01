import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:mockup/components/nav_button.dart';
import 'package:mockup/components/page_header.dart';
import 'package:mockup/components/textbox.dart';
import 'package:mockup/pages/new_appointment.dart';
import 'package:mockup/pages/view_Appointment.dart';
import 'package:mockup/utilities/palette.dart';

/*
void main() {
  runApp(MyApp());
}
*/
class MyAppointments extends StatefulWidget {
  const MyAppointments({Key? key}) : super(key: key);
  static String route = 'MyAppointments';

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
    return PageHeader(
      title: 'Your Appointments',
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
                        child: FancyText(
                            ftext: "Welcome Jebbidiah, here are your Tests",
                            style: Style.header),
                      ),
                      const FancyText(
                          ftext: "Good Luck on your tests!", style: Style.base),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Palette.lightOffWhite),
                  child: _createDataTable(),
                ),
                SizedBox(
                  height: 40,
                ),
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
