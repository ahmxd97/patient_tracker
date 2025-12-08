// lib/models/patient.dart
import 'record.dart';

class Patient {
  final int? id;
  final String name;
  final String contact;
  final int age;
  final String gender;
  final double height;
  final double weight;
  final String bloodGroup;
  final String bloodPressure;
  final String condition;
  final String doctorAssigned;
  final String address;
  final String emergencyContact;
  final String insurance;
  final String department; // emergency, elective direct, observation
  final String
      status; // waiting, appointment, surgery, after care, transferring
  final List<Record> records;

  Patient({
    this.id,
    required this.name,
    required this.contact,
    required this.age,
    required this.gender,
    required this.height,
    required this.weight,
    required this.bloodGroup,
    required this.bloodPressure,
    required this.condition,
    required this.doctorAssigned,
    required this.address,
    required this.emergencyContact,
    required this.insurance,
    required this.department,
    required this.status,
    this.records = const [],
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'contact': contact,
        'age': age,
        'gender': gender,
        'height': height,
        'weight': weight,
        'blood_group': bloodGroup,
        'blood_pressure': bloodPressure,
        'condition': condition,
        'doctor_assigned': doctorAssigned,
        'address': address,
        'emergency_contact': emergencyContact,
        'insurance': insurance,
        'department': department,
        'status': status,
      };
}
