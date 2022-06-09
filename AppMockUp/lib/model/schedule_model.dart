//import 'package:mockup/database/db_helper.dart';

import 'dart:collection';

class Schedules {
  int? scheduleId;
  String? date;
  String? time;
  String? type;
  String? location;
  DateTime? dateTime;

  Schedules(this.scheduleId, this.date, this.time, this.type, this.location);

  Schedules.fromMap(Map<String, dynamic> map) {
    scheduleId = map['scheduleId'];
    date = map['date'];
    time = map['time'];
    type = map['type'];
    location = map['location'];
    dateTime = DateTime.parse(date! + " " + time!);
  }

  Map<String, dynamic> toMap() {
    return {
      'scheduleId': scheduleId,
      'date': date,
      'time': time,
      'type': type,
      'location': location
    };
  }
}
