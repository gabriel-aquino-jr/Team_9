//import 'package:mockup/database/db_helper.dart';

class MyAppointmentsList {
  String? date;
  String? time;
  String? type;
  String? location;

  MyAppointmentsList(this.date, this.time, this.type, this.location);

  MyAppointmentsList.fromMap(Map<String, dynamic> map) {
    date = map['date'];
    time = map['time'];
    type = map['type'];
    location = map['location'];
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'time': time,
      'type': type,
      'location': location,
    };
  }
}
