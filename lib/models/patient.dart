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
      };
}
