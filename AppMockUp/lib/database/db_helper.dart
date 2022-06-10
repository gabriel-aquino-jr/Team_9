//import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mockup/model/customer_model.dart';
import 'package:mockup/model/global.dart';
import 'package:mockup/model/schedule_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../../model/global.dart';

class DBHelper {
  static const _dbName = 'snbDriveDB.db';
  static const _dbVersion = 1;

  //Creating a singleton class
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  //THere can only be one instance of the class running at any given time
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazy instatiation of the database the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  // Open the db. Create it if it doesnt exist
  _initDatabase() async {
    Directory docDirectory = await getApplicationDocumentsDirectory();
    String path = join(docDirectory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  // Create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE customers(
            customerId INTEGER PRIMARY KEY,
            fullName TEXT NOT NULL,
            email TEXT NOT NULL,
            password TEXT NOT NULL
        )
    ''');
    await db.execute('''CREATE TABLE appointments(
            customerId INTEGER NOT NULL,
            scheduleId INTEGER NOT NULL,
            PRIMARY KEY(customerId, scheduleId)
        )
    ''');
    await db.execute('''CREATE TABLE schedules(
            scheduleId INTEGER PRIMARY KEY,
            date TEXT NOT NULL,
            time TEXT NOT NULL,
            type TEXT NOT NULL,
            location TEXT NOT NULL
        )
    ''');
    debugPrint('Database $db created');
  }

  // Drop the database
  dropDatabase() async {
    Directory docDirectory = await getApplicationDocumentsDirectory();
    String path = join(docDirectory.path, _dbName);
    await deleteDatabase(path);
    debugPrint('Database at $path deleted');
  }

  // ***********************************************************************
  //                            Helper methods
  // ***********************************************************************

  // Inserts a row in the database where each key in the Map is a column nam
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(table, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns
  Future<List<Map<String, dynamic>>> queryAllRows(table) async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // Get a single line back, querying by id.
  Future<List<Map<String, dynamic>>> queryById(table, colId, id) async {
    Database db = await instance.database;
    return await db.query(table, where: "$colId = $id"); // Note ""
  }

  // ***********************************************************************
  //                     Customers table methods
  // ***********************************************************************

  // Insert records at the table
  Future<int> insertCustomer(Customers customers) async {
    Database db = await instance.database;
    return await db.insert('customers', {
      'fullName': customers.fullName,
      'email': customers.email,
      'password': customers.password
    });
  }

  Future<bool> authLogin(email, password) async {
    Database db = await instance.database;
    String emailText = email.text;
    String passwordText = password.text;
    final loginFound = await db.rawQuery('''SELECT customerId, fullName FROM 
      customers where email = '$emailText' and password = '$passwordText' ''');
    debugPrint('login records matched: {$loginFound.length}');
    if (loginFound.length == 1) {
      AppointmentInfo.customerId = loginFound[0]['customerId'].toString();
      AppointmentInfo.customerName = loginFound[0]['fullName'].toString();
    }
    return (loginFound.isNotEmpty);
  }

  Future<void> insertSampleData() async {
    Database db = await instance.database;
    db.rawDelete('DELETE FROM appointments');
    db.rawDelete('DELETE FROM schedules');
    db.rawDelete('DELETE FROM customers');
    debugPrint('Customers records deleted');
    debugPrint('Sample customer Inserted');
    await db.rawInsert('''INSERT INTO customers 
            (
            customerID,          
            fullName,
            email,
            password
            )
            VALUES
            (
              1,
              'John Doe',
            'jdoe@ca.ca',
            '123'
            )
    ''');

    await db.rawInsert('''INSERT INTO customers 
            (
            customerID,          
            fullName,
            email,
            password
            )
            VALUES
            (
              2,
              'Meg Ryan',
            'mryan@ca.ca',
            '123'
            )
    ''');
    //
    // In Order to parse times we must use ISO Format "2012-02-27 13:27:00"
    //

    // Genetate events for 60 days in the future
    String IdGenerator() {
      final now = DateTime.now();
      return now.microsecondsSinceEpoch.toString();
    }

    // LETS BUILD LOTS OF EVENTS!
    String schedulesSql = '''
            INSERT INTO schedules 
            (
            scheduleID,          
            date,
            time,
            type,
            location
            )
            VALUES
                        (
              1654803407812912,
              '2022-06-09',
              '08:30:00',
              'Road',
              'Moncton'
            ),
            (
              1654803407813655,
              '2022-06-09',
              '10:30:00',
              'Road',
              'Moncton'
            ),
            (
              1654803407813756,
              '2022-06-09',
              '13:30:00',
              'Road',
              'Woodstock'
            ),            (
              1654803407813921,
              '2022-06-10',
              '08:30:00',
              'Road',
              'Edmundston'
            ),
            (
              1654803407814015,
              '2022-06-10',
              '10:30:00',
              'Road',
              'Bathurst'
            ),
            (
              1654803407814359,
              '2022-06-10',
              '13:30:00',
              'Road',
              'Woodstock'
            ),            (
              1654803407814443,
              '2022-06-11',
              '08:30:00',
              'Road',
              'Moncton'
            ),
            (
              1654803407814475,
              '2022-06-11',
              '10:30:00',
              'Road',
              'Woodstock'
            ),
            (
              1654803407814502,
              '2022-06-11',
              '13:30:00',
              'Road',
              'Woodstock'
            ),            (
              1654803407814551,
              '2022-06-12',
              '08:30:00',
              'Road',
              'Bathurst'
            ),
            (
              1654803407814582,
              '2022-06-12',
              '10:30:00',
              'Road',
              'Woodstock'
            ),
            (
              1654803407814605,
              '2022-06-12',
              '13:30:00',
              'Road',
              'Edmundston'
            ),            (
              1654803407814649,
              '2022-06-13',
              '08:30:00',
              'Road',
              'Woodstock'
            ),
            (
              1654803407814680,
              '2022-06-13',
              '10:30:00',
              'Road',
              'Bathurst'
            ),
            (
              1654803407814701,
              '2022-06-13',
              '13:30:00',
              'Road',
              'Bathurst'
            ),            (
              1654803407814740,
              '2022-06-14',
              '08:30:00',
              'Road',
              'Woodstock'
            ),
            (
              1654803407814769,
              '2022-06-14',
              '10:30:00',
              'Road',
              'Woodstock'
            ),
            (
              1654803407814790,
              '2022-06-14',
              '13:30:00',
              'Road',
              'Moncton'
            ),            (
              1654803407814829,
              '2022-06-15',
              '08:30:00',
              'Road',
              'Bathurst'
            ),
            (
              1654803407814860,
              '2022-06-15',
              '10:30:00',
              'Road',
              'Woodstock'
            ),
            (
              1654803407814888,
              '2022-06-15',
              '13:30:00',
              'Road',
              'Bathurst'
            ),            (
              1654803407814947,
              '2022-06-16',
              '08:30:00',
              'Road',
              'Bathurst'
            ),
            (
              1654803407815016,
              '2022-06-16',
              '10:30:00',
              'Road',
              'Woodstock'
            ),
            (
              1654803407815048,
              '2022-06-16',
              '13:30:00',
              'Road',
              'Edmundston'
            ),            (
              1654803407815860,
              '2022-06-17',
              '08:30:00',
              'Road',
              'Sackville'
            ),
            (
              1654803407815915,
              '2022-06-17',
              '10:30:00',
              'Road',
              'Moncton'
            ),
            (
              1654803407815943,
              '2022-06-17',
              '13:30:00',
              'Road',
              'Sackville'
            ),            (
              1654803407816089,
              '2022-06-18',
              '08:30:00',
              'Road',
              'Sackville'
            ),
            (
              1654803407816134,
              '2022-06-18',
              '10:30:00',
              'Road',
              'Moncton'
            ),
            (
              1654803407816164,
              '2022-06-18',
              '13:30:00',
              'Road',
              'Edmundston'
            )
        ''';

    // Map newEvents = List<DateTime>.generate(
    //     10,
    //     (i) => DateTime.utc(
    //             DateTime.now().year, DateTime.now().month, DateTime.now().day)
    //         .add(Duration(days: i))).asMap();

    // // Build SQL String
    // newEvents.forEach((index, element) => {
    //       schedulesSql += '''
    //         (
    //           ${IdGenerator()},
    //           '${element.year}-${element.month.toString().length == 0 ? element.month : ("0" + element.month.toString())}-${element.day.toString().length == 1 ? element.day : ("0" + element.day.toString())}',
    //           '08:30:00',
    //           'Road',
    //           'Moncton'
    //         ),
    //         (
    //           ${IdGenerator()},
    //           '${element.year}-${element.month.toString().length == 0 ? element.month : ("0" + element.month.toString())}-${element.day.toString().length == 1 ? element.day : ("0" + element.day.toString())}',
    //           '10:30:00',
    //           'Road',
    //           'Moncton'
    //         ),
    //         (
    //           ${IdGenerator()},
    //           '${element.year}-${element.month.toString().length == 0 ? element.month : ("0" + element.month.toString())}-${element.day.toString().length == 1 ? element.day : ("0" + element.day.toString())}',
    //           '13:30:00',
    //           'Road',
    //           'Moncton'
    //         ),'''
    //     });
    // // we have to delete the last comma
    // schedulesSql = schedulesSql.substring(0, schedulesSql.length - 1);

    // Insert Scheduel SqlString
    int lastRowSchedule = await db.rawInsert(schedulesSql);
    print(lastRowSchedule);

    // Insert Appointments

    int lastrowAppt = await db.rawInsert('''INSERT INTO appointments 
            (
            customerID,
            scheduleID
            )
            VALUES
            (
              1,
              1654803407816164
            )
    ''');
    await db.rawInsert('''INSERT INTO appointments 
            (
            customerID,
            scheduleID
            )
            VALUES
            (
              1,
              1654803407813655
            )
    ''');

    await db.rawInsert('''INSERT INTO appointments 
            (
            customerID,
            scheduleID
            )
            VALUES
            (
              1,
              1654803407815915
            )
    ''');

    await db.rawInsert('''INSERT INTO appointments 
            (
            customerID,
            scheduleID
            )
            VALUES
            (
              2,
              1654803407814502
            )
    ''');

    await db.rawInsert('''INSERT INTO appointments 
            (
            customerID,
            scheduleID
            )
            VALUES
            (
              2,
              1654803407816089
            )
    ''');

    print(lastrowAppt);
  }

  // ***********************************************************************
  //                     Appointments table methods
  // ***********************************************************************

  Future<int> insertAppointment(customerId, scheduleId) async {
    Database db = await instance.database;
    debugPrint('Inserting appointment');
    return await db.rawInsert('''INSERT INTO appointments
            (
            customerID,
            scheduleID
            )
            VALUES
            (
              ${customerId},
              ${scheduleId}            
            )
    ''');
  }

  // Query all appointments from a customer
  Future<List<Map<String, dynamic>>> queryGetScheduleID(
      String date, String time, String type, String location) async {
    Database db = await instance.database;
    final resultSet = await db.rawQuery('''
        SELECT
          scheduleID
        FROM Schedules
        WHERE 
          date = '${date}' AND
          time = '${time}' AND
          type = '${type}' AND
          location = '${location}'
        LIMIT 1         
        ''');
    return resultSet;
  }

  // Query all appointments from a customer
  Future<List<Map<String, dynamic>>> queryMyAppointments(customerId) async {
    Database db = await instance.database;
    final resultSet = await db.rawQuery('''
        SELECT
          date,
          time,
          type,
          location
        FROM Schedules
        INNER JOIN Appointments
        ON Schedules.scheduleID = Appointments.scheduleID
        WHERE Appointments.customerID = $customerId
        ''');
    return resultSet;
  }
/*
  // We are assuming here that the id column the map is set. The other column
  // values will be used to update the row.
  Future<int> updateEmployee(Employees employee) async {
    Database db = await instance.database;
    int id = employee.toMap()['id'];
    return await db.update(table, employee.toMap(),
        where: '$colId = ?', whereArgs: [id]); // Note ''
  }
*/

  // ***********************************************************************
  //                     Schedules table methods
  // ***********************************************************************

  // Query number of cities
  Future<int> queryQtyCities() async {
    Database db = await instance.database;
    final resultSet = await db.rawQuery('''
        SELECT
          count(location)
        FROM Schedules
        ''');
    return resultSet.length;
  }

  // Query cities with schedules available
  Future<List<Map<String, dynamic>>> queryCitiesAvailable() async {
    Database db = await instance.database;
    final resultSet = await db.rawQuery('''
        SELECT
          distinct location
        FROM schedules
        ''');
    return resultSet;
  }

  // Query cities with schedules available
  Future<List<Map<String, dynamic>>> queryDatesAvailable(
      String type, String city) async {
    Database db = await instance.database;
    final resultSet = await db.rawQuery('''
        SELECT
          *
        FROM schedules
        LEFT OUTER JOIN Appointments
          ON schedules.ScheduleID = Appointments.ScheduleID
        WHERE 
          Appointments.ScheduleID is null AND 
          Type = '${type}' AND
          Location = '${city}'
        ''');
    return resultSet;
  }

  // Insert records at the table
  Future<int> insertSchedule(Schedules schedules) async {
    Database db = await instance.database;
    return await db.insert('schedules', {
      'date': schedules.date,
      'time': schedules.time,
      'type': schedules.type,
      'location': schedules.location
    });
  }
}
