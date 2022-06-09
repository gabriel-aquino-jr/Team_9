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
              1654798778258508,
              '2022-6-9',
              '8:30:00',
              'Road',
              'Moncton'
            ),
    (
      1654798778258787,
      '2022-6-9',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778258913,
      '2022-6-9',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778259197,
      '2022-6-10',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778259221,
      '2022-6-10',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778259245,
      '2022-6-10',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778259291,
      '2022-6-11',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778259314,
      '2022-6-11',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778259401,
      '2022-6-11',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778259744,
      '2022-6-12',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778259793,
      '2022-6-12',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778259822,
      '2022-6-12',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778259874,
      '2022-6-13',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778259911,
      '2022-6-13',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778259935,
      '2022-6-13',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778259981,
      '2022-6-14',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778260016,
      '2022-6-14',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778260041,
      '2022-6-14',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778260087,
      '2022-6-15',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778260128,
      '2022-6-15',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778260156,
      '2022-6-15',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778260209,
      '2022-6-16',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778260254,
      '2022-6-16',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778260281,
      '2022-6-16',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778260401,
      '2022-6-17',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778260446,
      '2022-6-17',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778260474,
      '2022-6-17',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778260535,
      '2022-6-18',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778260585,
      '2022-6-18',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778260615,
      '2022-6-18',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778260690,
      '2022-6-19',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778260734,
      '2022-6-19',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778261025,
      '2022-6-19',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778261077,
      '2022-6-20',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778261102,
      '2022-6-20',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778261135,
      '2022-6-20',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778261333,
      '2022-6-21',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778261372,
      '2022-6-21',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778261397,
      '2022-6-21',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778261452,
      '2022-6-22',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778261490,
      '2022-6-22',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778261518,
      '2022-6-22',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778261601,
      '2022-6-23',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778261675,
      '2022-6-23',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778261704,
      '2022-6-23',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778261854,
      '2022-6-24',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778261899,
      '2022-6-24',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778261924,
      '2022-6-24',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778261998,
      '2022-6-25',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778262037,
      '2022-6-25',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778262064,
      '2022-6-25',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778262151,
      '2022-6-26',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778262199,
      '2022-6-26',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778262223,
      '2022-6-26',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778262289,
      '2022-6-27',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778262321,
      '2022-6-27',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778262342,
      '2022-6-27',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778262400,
      '2022-6-28',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778262431,
      '2022-6-28',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778262454,
      '2022-6-28',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778262533,
      '2022-6-29',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778262588,
      '2022-6-29',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778262723,
      '2022-6-29',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778262817,
      '2022-6-30',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778262860,
      '2022-6-30',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778262903,
      '2022-6-30',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778262981,
      '2022-7-1',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778263021,
      '2022-7-1',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778263341,
      '2022-7-1',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778263416,
      '2022-7-2',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778263456,
      '2022-7-2',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778263483,
      '2022-7-2',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778263555,
      '2022-7-3',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778263604,
      '2022-7-3',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778263631,
      '2022-7-3',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778263707,
      '2022-7-4',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778263744,
      '2022-7-4',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778263771,
      '2022-7-4',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778263851,
      '2022-7-5',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778263889,
      '2022-7-5',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778263916,
      '2022-7-5',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778263996,
      '2022-7-6',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778264033,
      '2022-7-6',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778264059,
      '2022-7-6',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778264139,
      '2022-7-7',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778264177,
      '2022-7-7',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778264204,
      '2022-7-7',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778264284,
      '2022-7-8',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778264322,
      '2022-7-8',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778264349,
      '2022-7-8',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778264434,
      '2022-7-9',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778264475,
      '2022-7-9',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778264503,
      '2022-7-9',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778265097,
      '2022-7-10',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778265321,
      '2022-7-10',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778265348,
      '2022-7-10',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778265430,
      '2022-7-11',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778265521,
      '2022-7-11',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778265546,
      '2022-7-11',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778265648,
      '2022-7-12',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778265672,
      '2022-7-12',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778265692,
      '2022-7-12',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778265750,
      '2022-7-13',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778265770,
      '2022-7-13',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778265789,
      '2022-7-13',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778265851,
      '2022-7-14',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778265873,
      '2022-7-14',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778265891,
      '2022-7-14',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778265958,
      '2022-7-15',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778265977,
      '2022-7-15',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778265995,
      '2022-7-15',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778266082,
      '2022-7-16',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778266115,
      '2022-7-16',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778266137,
      '2022-7-16',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778266222,
      '2022-7-17',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778266256,
      '2022-7-17',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778266279,
      '2022-7-17',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778266360,
      '2022-7-18',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778266393,
      '2022-7-18',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778266417,
      '2022-7-18',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778266503,
      '2022-7-19',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778266535,
      '2022-7-19',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778266558,
      '2022-7-19',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778266694,
      '2022-7-20',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778266725,
      '2022-7-20',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778266745,
      '2022-7-20',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778266816,
      '2022-7-21',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778266854,
      '2022-7-21',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778266878,
      '2022-7-21',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778266968,
      '2022-7-22',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778267000,
      '2022-7-22',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778267024,
      '2022-7-22',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778267097,
      '2022-7-23',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778267127,
      '2022-7-23',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778267153,
      '2022-7-23',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778267242,
      '2022-7-24',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778267385,
      '2022-7-24',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778267413,
      '2022-7-24',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778267517,
      '2022-7-25',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778267550,
      '2022-7-25',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778267580,
      '2022-7-25',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778267673,
      '2022-7-26',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778267708,
      '2022-7-26',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778267731,
      '2022-7-26',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778267872,
      '2022-7-27',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778267914,
      '2022-7-27',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778267937,
      '2022-7-27',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778268043,
      '2022-7-28',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778268081,
      '2022-7-28',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778268102,
      '2022-7-28',
      '13:30:00',
      'Road',
      'Moncton'
    ),            (
      1654798778268268,
      '2022-7-29',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778268318,
      '2022-7-29',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778268342,
      '2022-7-29',
      '13:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778268443,
      '2022-7-30',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778268475,
      '2022-7-30',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778268497,
      '2022-7-30',
      '13:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778268607,
      '2022-7-31',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778268640,
      '2022-7-31',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778268663,
      '2022-7-31',
      '13:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778268759,
      '2022-8-1',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778268790,
      '2022-8-1',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778268813,
      '2022-8-1',
      '13:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778268912,
      '2022-8-2',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778268947,
      '2022-8-2',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778268970,
      '2022-8-2',
      '13:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778269084,
      '2022-8-3',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778269113,
      '2022-8-3',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778269133,
      '2022-8-3',
      '13:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778269231,
      '2022-8-4',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778269258,
      '2022-8-4',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778269278,
      '2022-8-4',
      '13:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778269381,
      '2022-8-5',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778269423,
      '2022-8-5',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778269450,
      '2022-8-5',
      '13:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778269574,
      '2022-8-6',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778270169,
      '2022-8-6',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778270191,
      '2022-8-6',
      '13:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778270305,
      '2022-8-7',
      '8:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778270326,
      '2022-8-7',
      '10:30:00',
      'Road',
      'Moncton'
    ),
    (
      1654798778270350,
      '2022-8-7',
      '13:30:00',
      'Road',
      'Moncton'
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
    //           '${element.year}-${element.month}-${element.day}',
    //           '8:30:00',
    //           'Road',
    //           'Moncton'
    //         ),
    //         (
    //           ${IdGenerator()},
    //           '${element.year}-${element.month}-${element.day}',
    //           '10:30:00',
    //           'Road',
    //           'Moncton'
    //         ),
    //         (
    //           ${IdGenerator()},
    //           '${element.year}-${element.month}-${element.day}',
    //           '13:30:00',
    //           'Road',
    //           'Moncton'
    //         ),'''
    //     });
    // // we have to delete the last comma
    // schedulesSql = schedulesSql.substring(0, schedulesSql.length - 1);

    // Insert Scheduel SqlString
    int recordsaffected = await db.rawInsert(schedulesSql);
    print(recordsaffected);

    // Insert Appointments

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
