// lib/db/database.dart
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import '../models/patient.dart';
import '../models/record.dart';

class DatabaseHelper {
  static Database? _db;
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    WidgetsFlutterBinding.ensureInitialized();
    return openDatabase(
      join(await getDatabasesPath(), 'patient.db'),
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE patients(id INTEGER PRIMARY KEY, name TEXT, contact TEXT, age INTEGER, gender TEXT, height REAL, weight REAL, blood_group TEXT, blood_pressure TEXT, condition TEXT, doctor_assigned TEXT, address TEXT, emergency_contact TEXT, insurance TEXT, department TEXT, status TEXT)');
        await db.execute(
            'CREATE TABLE records(id INTEGER PRIMARY KEY, patient_id INTEGER, note TEXT)');
        // Sample patients
        await db.insert(
            'patients',
            Patient(
              name: 'John Doe',
              contact: '1234567890',
              age: 45,
              gender: 'Male',
              height: 180.0,
              weight: 75.0,
              bloodGroup: 'O+',
              bloodPressure: '120/80',
              condition: 'Hypertension',
              doctorAssigned: 'D001',
              address: '123 Main St',
              emergencyContact: '9876543210',
              insurance: 'ABC Insurance',
              department: 'Emergency',
              status: 'Waiting',
            ).toMap());
        await db.insert(
            'patients',
            Patient(
              name: 'Jane Smith',
              contact: '0987654321',
              age: 30,
              gender: 'Female',
              height: 165.0,
              weight: 60.0,
              bloodGroup: 'A+',
              bloodPressure: '110/70',
              condition: 'Diabetes',
              doctorAssigned: 'D002',
              address: '456 Elm St',
              emergencyContact: '1234567890',
              insurance: 'XYZ Insurance',
              department: 'Observation',
              status: 'Appointment',
            ).toMap());
        // Additional 5 placeholders
        await db.insert(
            'patients',
            Patient(
              name: 'Alice Johnson',
              contact: '5551234567',
              age: 28,
              gender: 'Female',
              height: 170.0,
              weight: 55.0,
              bloodGroup: 'B+',
              bloodPressure: '115/75',
              condition: 'Asthma',
              doctorAssigned: 'D001',
              address: '789 Oak Ave',
              emergencyContact: '5557654321',
              insurance: 'HealthCorp',
              department: 'Elective Direct',
              status: 'Surgery',
            ).toMap());
        await db.insert(
            'patients',
            Patient(
              name: 'Bob Brown',
              contact: '4449876543',
              age: 52,
              gender: 'Male',
              height: 175.0,
              weight: 80.0,
              bloodGroup: 'AB-',
              bloodPressure: '130/85',
              condition: 'Arthritis',
              doctorAssigned: 'D002',
              address: '321 Pine Rd',
              emergencyContact: '4443219876',
              insurance: 'MediCare',
              department: 'Emergency',
              status: 'After Care',
            ).toMap());
        await db.insert(
            'patients',
            Patient(
              name: 'Carol Davis',
              contact: '3336549870',
              age: 35,
              gender: 'Female',
              height: 160.0,
              weight: 65.0,
              bloodGroup: 'O-',
              bloodPressure: '118/78',
              condition: 'Allergy',
              doctorAssigned: 'D001',
              address: '654 Cedar Ln',
              emergencyContact: '3330987654',
              insurance: 'BlueCross',
              department: 'Observation',
              status: 'Transferring',
            ).toMap());
        await db.insert(
            'patients',
            Patient(
              name: 'David Evans',
              contact: '2223456789',
              age: 40,
              gender: 'Male',
              height: 185.0,
              weight: 90.0,
              bloodGroup: 'A-',
              bloodPressure: '125/80',
              condition: 'Back Pain',
              doctorAssigned: 'D002',
              address: '987 Birch Blvd',
              emergencyContact: '2228765432',
              insurance: 'Aetna',
              department: 'Elective Direct',
              status: 'Waiting',
            ).toMap());
        await db.insert(
            'patients',
            Patient(
              name: 'Eve Foster',
              contact: '1112345678',
              age: 25,
              gender: 'Others',
              height: 172.0,
              weight: 68.0,
              bloodGroup: 'B-',
              bloodPressure: '112/72',
              condition: 'Migraine',
              doctorAssigned: 'D001',
              address: '135 Maple Ct',
              emergencyContact: '1117654321',
              insurance: 'Cigna',
              department: 'Emergency',
              status: 'Appointment',
            ).toMap());
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
    print('DEBUG: Retrieved ${maps.length} patients from database');
    return maps.map((map) {
      // Robust conversions: sqflite may return int for REAL fields
      final id = map['id'] as int?;
      final name = map['name'] as String? ?? '';
      final contact = map['contact'] as String? ?? '';
      final age = (map['age'] is num)
          ? (map['age'] as num).toInt()
          : int.tryParse(map['age']?.toString() ?? '0') ?? 0;
      final gender = map['gender'] as String? ?? '';
      final height = (map['height'] is num)
          ? (map['height'] as num).toDouble()
          : double.tryParse(map['height']?.toString() ?? '0') ?? 0.0;
      final weight = (map['weight'] is num)
          ? (map['weight'] as num).toDouble()
          : double.tryParse(map['weight']?.toString() ?? '0') ?? 0.0;
      final bloodGroup = map['blood_group'] as String? ?? '';
      final bloodPressure = map['blood_pressure'] as String? ?? '';
      final condition = map['condition'] as String? ?? '';
      final doctorAssigned = map['doctor_assigned'] as String? ?? '';
      final address = map['address'] as String? ?? '';
      final emergencyContact = map['emergency_contact'] as String? ?? '';
      final insurance = map['insurance'] as String? ?? '';
      final department = map['department'] as String? ?? '';
      final status = map['status'] as String? ?? '';

      return Patient(
        id: id,
        name: name,
        contact: contact,
        age: age,
        gender: gender,
        height: height,
        weight: weight,
        bloodGroup: bloodGroup,
        bloodPressure: bloodPressure,
        condition: condition,
        doctorAssigned: doctorAssigned,
        address: address,
        emergencyContact: emergencyContact,
        insurance: insurance,
        department: department,
        status: status,
      );
    }).toList();
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
