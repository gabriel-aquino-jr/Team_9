import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mockup/model/customer_model.dart';
import 'package:mockup/model/schedule_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

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
    final loginFound = await db.rawQuery('''SELECT * FROM customers
        where email = '$emailText' and password = '$passwordText' ''');
    debugPrint('login records matched: {$loginFound.length}');
    return (loginFound.isNotEmpty);
  }

  Future<void> insertSampleCustomer() async {
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

    //
    // In Order to parse times we must use ISO Format "2012-02-27 13:27:00"
    //
    await db.rawInsert('''
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
              1,
              '2022-07-01',
              '12:30:00',
              'Road',
              'Moncton'
            )
    ''');
    await db.rawInsert('''
            INSERT schedules 
            (
            scheduleID,          
            date,
            time,
            type,
            location
            )
            VALUES
            (
              2,
              '2022-06-10',
              '12:30:00',
              'Road',
              'Moncton'
            )
    ''');
    await db.rawInsert('''
            INSERT schedules 
            (
            scheduleID,          
            date,
            time,
            type,
            location
            )
            VALUES
            (
              3,
              '2022-06-10',
              '12:30:00',
              'Road',
              'Moncton'
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
              1
            )
    ''');
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
              ${customerId.text},
              ${scheduleId.text}            
            )
    ''');
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
