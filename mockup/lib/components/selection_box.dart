import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:mockup/components/nav_button.dart';
import 'package:mockup/components/page_header.dart';
import 'package:mockup/pages/new_appointment.dart';
import 'package:mockup/pages/view_Appointment.dart';

/*
void main() {
  runApp(MyApp());
}
*/
class MyAppointments extends StatefulWidget {
  const MyAppointments({Key? key, required this.header}) : super(key: key);

  static String route = 'MyAppointments';

  final List<String> header;

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
    return Padding(
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
    );
  }

  DataTable _createDataTable() {
    return DataTable(
        columns: List<DataColumn>.from(_createColumns(ReturnType.dataColumn)),
        rows: _createRows());
  }

  List<dynamic> _createColumns(ReturnType retType) {
    List<dynamic> headerColumn = [];
    /*headerColumn = widget.header.forEach(
      (String aHeader) => DataColumn(
        label: Text(aHeader),
      ),
    );*/
    for (String aHeader in widget.header) {
      if (retType == ReturnType.dataColumn) {
        headerColumn.add(DataColumn(label: Text(aHeader)));
      }
      if (retType == ReturnType.dataCell) {
        headerColumn.add(DataCell(Text(aHeader)));
      }
    }
    return headerColumn;
  }

  List<DataRow> _createRows() {
    return _appointments
        .mapIndexed((index, appointment) => DataRow(
              cells: List<DataCell>.from(_createColumns(ReturnType.dataCell)),
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

enum ReturnType { dataColumn, dataCell }
