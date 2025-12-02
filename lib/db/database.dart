import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import '../models/patient.dart';
import '../models/record.dart';

class DatabaseHelper {
  static Database? _db;

  Future<Database> get db async {
    WidgetsFlutterBinding.ensureInitialized();
    _db ??= await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    return openDatabase(
      join(await getDatabasesPath(), 'patient.db'),
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE patients(id INTEGER PRIMARY KEY, name TEXT, contact TEXT, age INTEGER, gender TEXT, height REAL, weight REAL, blood_group TEXT, blood_pressure TEXT, condition TEXT, doctor_assigned TEXT)');
        await db.execute(
            'CREATE TABLE records(id INTEGER PRIMARY KEY, patient_id INTEGER, note TEXT)');
      },
      version: 1,
    );
  }

  Future<int> insertPatient(Patient patient) async {
    var database = await db;
    return await database.insert('patients', patient.toMap());
  }

  Future<List<Patient>> getPatients() async {
    var database = await db;
    List<Map<String, dynamic>> maps = await database.query('patients');
    return maps
        .map((map) => Patient(
              id: map['id'] as int?,
              name: map['name'] as String,
              contact: map['contact'] as String,
              age: map['age'] as int,
              gender: map['gender'] as String,
              height: map['height'] as double,
              weight: map['weight'] as double,
              bloodGroup: map['blood_group'] as String,
              bloodPressure: map['blood_pressure'] as String,
              condition: map['condition'] as String,
              doctorAssigned: map['doctor_assigned'] as String,
            ))
        .toList();
  }

  Future<int> insertRecord(Record record) async {
    var database = await db;
    return await database.insert('records', record.toMap());
  }

  Future<List<Record>> getRecords(int patientId) async {
    var database = await db;
    List<Map<String, dynamic>> maps = await database
        .query('records', where: 'patient_id = ?', whereArgs: [patientId]);
    return maps
        .map((map) => Record(
              id: map['id'] as int?,
              patientId: map['patient_id'] as int,
              note: map['note'] as String,
            ))
        .toList();
  }

  Future<int> updatePatient(Patient patient) async {
    var database = await db;
    return await database.update('patients', patient.toMap(),
        where: 'id = ?', whereArgs: [patient.id]);
  }

  Future<void> deletePatient(int id) async {
    var database = await db;
    await database.delete('patients', where: 'id = ?', whereArgs: [id]);
    await database.delete('records', where: 'patient_id = ?', whereArgs: [id]);
  }
}
