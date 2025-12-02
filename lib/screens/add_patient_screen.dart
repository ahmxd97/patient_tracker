import 'package:flutter/material.dart';
import '../db/database.dart';
import '../models/patient.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class AddPatientScreen extends StatefulWidget {
  @override
  _AddPatientScreenState createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  final _name = TextEditingController();
  final _contact = TextEditingController();
  final _age = TextEditingController();
  final _height = TextEditingController();
  final _weight = TextEditingController();
  final _bloodPressure = TextEditingController();
  final _condition = TextEditingController();
  final _doctorAssigned = TextEditingController();

  String? _gender;
  String? _bloodGroup;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Patient'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/admin'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
              context.go('/');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
                controller: _name,
                decoration: const InputDecoration(labelText: 'Name')),
            TextField(
                controller: _contact,
                decoration: const InputDecoration(labelText: 'Contact')),
            TextField(
                controller: _age,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Age')),
            DropdownButton<String>(
              value: _gender,
              hint: const Text('Gender'),
              items: ['Male', 'Female', 'Others'].map((String value) {
                return DropdownMenuItem<String>(
                    value: value, child: Text(value));
              }).toList(),
              onChanged: (newValue) => setState(() => _gender = newValue),
            ),
            TextField(
                controller: _height,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Height (cm)')),
            TextField(
                controller: _weight,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Weight (kg)')),
            DropdownButton<String>(
              value: _bloodGroup,
              hint: const Text('Blood Group'),
              items: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
                  .map((String value) {
                return DropdownMenuItem<String>(
                    value: value, child: Text(value));
              }).toList(),
              onChanged: (newValue) => setState(() => _bloodGroup = newValue),
            ),
            TextField(
                controller: _bloodPressure,
                decoration: const InputDecoration(labelText: 'Blood Pressure')),
            TextField(
                controller: _condition,
                decoration: const InputDecoration(labelText: 'Condition')),
            TextField(
                controller: _doctorAssigned,
                decoration: const InputDecoration(
                    labelText: 'Assigned Doctor ID (e.g., D001)')),
            ElevatedButton(
              onPressed: () async {
                if (_gender != null && _bloodGroup != null) {
                  final patient = Patient(
                    name: _name.text,
                    contact: _contact.text,
                    age: int.tryParse(_age.text) ?? 0,
                    gender: _gender!,
                    height: double.tryParse(_height.text) ?? 0.0,
                    weight: double.tryParse(_weight.text) ?? 0.0,
                    bloodGroup: _bloodGroup!,
                    bloodPressure: _bloodPressure.text,
                    condition: _condition.text,
                    doctorAssigned: _doctorAssigned.text,
                  );
                  await DatabaseHelper().insertPatient(patient);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Patient info saved',
                          style: TextStyle(color: Colors.white))));
                  context.go('/admin');
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
