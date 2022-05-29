import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

/*
void main() {
  runApp(MyApp());
}
*/
class MyAppointments extends StatefulWidget {
  const MyAppointments({Key? key, required this.title}) : super(key: key);

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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Your Appointments'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [_createDataTable()],
          ),

/*          ElevatedButton(
                  onPressed,
                  child: const Text(
                    'Insert',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                */
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
                }))
        .toList();
  }
}
