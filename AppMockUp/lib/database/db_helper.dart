import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mockup/model/customer_model.dart';
import 'package:mockup/model/schedule_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const _dbName = 'snbDrive.db';
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
            customerId INTEGER PRIMARY KEY AUTOINCREMENT,
            fullName TEXT NOT NULL,
            email TEXT NOT NULL,
            password TEXT NOT NULL
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

  Future<bool> authLogin(String email, String password) async {
    Database db = await instance.database;
    final loginFound = await db.query('customer',
        where: "email = $email and password = $password"); // Note ""
    return (loginFound.isNotEmpty);
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
