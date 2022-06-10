import 'package:flutter/material.dart';
import 'package:mockup/components/nav_button.dart';
//import 'package:collection/collection.dart';
import 'package:mockup/components/page_header.dart';
import 'package:mockup/components/textbox.dart';
//import 'package:mockup/components/textbox.dart';
import 'package:mockup/database/db_helper.dart';
import 'package:mockup/model/myappointment_model.dart';
import 'package:mockup/pages/new_appointment.dart';
import 'package:mockup/pages/view_Appointment.dart';
import 'package:mockup/utilities/palette.dart';
import '../../model/global.dart';

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
  final dbHelper = DBHelper.instance;

  // The following list is already sorted by id
  List<MyAppointmentsList> _appointments = [];

  void _queryMyAppointments() async {
    dbHelper.database;
    final allRows =
        await dbHelper.queryMyAppointments(AppointmentInfo.customerId);
    debugPrint('query appointments from customer');
    _appointments.clear(); // clearing employees left over
    for (var row in allRows) {
      _appointments.add(MyAppointmentsList.fromMap(row));
    }
    setState(() {});
    allRows.forEach(print);
  }

  @override
  void initState() {
    super.initState();
    _queryMyAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return PageHeader(
      title: 'Your Appointments',
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FancyText(
                  ftext: 'Welcome, ${AppointmentInfo.customerName}!',
                  style: Style.header,
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _appointments.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          debugPrint('Card #$index was tapped');
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('${_appointments[index].date}'),
                                Text('- ${_appointments[index].time}'),
                                Text('- ${_appointments[index].type}'),
                                Text('- ${_appointments[index].location}'),
                                const Spacer(),
                                IconButton(
                                  icon: const Icon(Icons.details_outlined),
                                  color: Colors.blue,
                                  onPressed: () {
                                    debugPrint('go to the appointment details');
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          NavBtn(label: 'New', route: NewAppointment.route),
          SizedBox(
            height: 20,
          ),
        ],
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(10.0),
      //   child: ListView(
      //     children: [
      //       Column(
      //         children: [
      //           Padding(
      //             padding: const EdgeInsets.all(20.0),
      //             child: Column(
      //               children: [
      //                 const Padding(
      //                   padding: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
      //                   child: FancyText(
      //                       ftext: "Welcome Jebbidiah, here are your Tests",
      //                       style: Style.header),
      //                 ),
      //                 const FancyText(
      //                     ftext: "Good Luck on your tests!", style: Style.base),
      //               ],
      //             ),
      //           ),
      //           Container(
      //             decoration: BoxDecoration(color: Palette.lightOffWhite),
      //             child: await _createDataTable(),
      //           ),
      //           SizedBox(
      //             height: 40,
      //           ),
      //           NavBtn(label: 'New', route: NewAppointment.route)
      //         ],
      //       )
      //     ],
      //   ),
      // ),
    );
  }

  //Future<List<Appointments>> _appointments = [];

  // Future<DataTable> _createDataTable() async {
  //   return DataTable(columns: _createColumns(), rows: await _createRows());
  // }

  // List<DataColumn> _createColumns() {
  //   return [
  //     const DataColumn(label: Text('Date')),
  //     const DataColumn(label: Text('Time')),
  //     const DataColumn(label: Text('Type')),
  //     const DataColumn(label: Text('Location')),
  //   ];
  // }

  // Future<List<DataRow>> _createRows() async {
  //   _appointments = await dbHelper.queryAllRows('appointments');

  //   //_appointments = await dbHelper.queryAllRows('appointments');
  //   return _appointments
  //       .mapIndexed((index, appointment) => DataRow(
  //             cells: [
  //               DataCell(Text(appointment['date'])),
  //               DataCell(Text(appointment['time'])),
  //               DataCell(Text(appointment['type'])),
  //               DataCell(Text(appointment['location']))
  //             ],
  //             selected: _selected[index],
  //             onSelectChanged: (bool? selected) {
  //               setState(() {
  //                 _selected[index] = selected!;
  //               });
  //             },
  //             onLongPress: () {
  //               Navigator.pushNamed(context, ViewAppointments.route);
  //             },
  //           ))
  //       .toList();
  // }
}
