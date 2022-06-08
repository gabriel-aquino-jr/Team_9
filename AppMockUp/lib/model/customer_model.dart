//import 'package:mockup/database/db_helper.dart';

class Customers {
  int? customerId;
  String? fullName;
  String? email;
  String? password;

  Customers(this.customerId, this.fullName, this.email, this.password);

  Customers.fromMap(Map<String, dynamic> map) {
    customerId = map['customerId'];
    fullName = map['fullName'];
    email = map['email'];
    password = map['password'];
  }

  Map<String, dynamic> toMap() {
    return {
      'customerId': customerId,
      'fullName': fullName,
      'email': email,
      'password': password
    };
  }
}
