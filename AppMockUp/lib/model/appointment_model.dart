//import 'package:mockup/database/db_helper.dart';

class Appointments {
  int? customerId;
  int? scheduleId;

  Appointments(this.customerId, this.scheduleId);

  Appointments.fromMap(Map<String, dynamic> map) {
    customerId = map['customerId'];
    scheduleId = map['scheduleId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'customerId': customerId,
      'scheduleId': scheduleId,
    };
  }
}
