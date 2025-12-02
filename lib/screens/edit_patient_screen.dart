import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../db/database.dart';
import '../models/patient.dart';
import '../providers/auth_provider.dart';
import 'package:go_router/go_router.dart';

class EditPatientScreen extends StatefulWidget {
  final Patient patient;

  const EditPatientScreen({super.key, required this.patient});

  @override
  _EditPatientScreenState createState() => _EditPatientScreenState();
}

class _EditPatientScreenState extends State<EditPatientScreen> {
  late TextEditingController _name;
  late TextEditingController _contact;
  late TextEditingController _age;
  late TextEditingController _height;
  late TextEditingController _weight;
  late TextEditingController _bloodPressure;
  late TextEditingController _condition;
  late TextEditingController _doctorAssigned;

  late String _gender;
  late String _bloodGroup;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.patient.name);
    _contact = TextEditingController(text: widget.patient.contact);
    _age = TextEditingController(text: widget.patient.age.toString());
    _height = TextEditingController(text: widget.patient.height.toString());
    _weight = TextEditingController(text: widget.patient.weight.toString());
    _bloodPressure = TextEditingController(text: widget.patient.bloodPressure);
    _condition = TextEditingController(text: widget.patient.condition);
    _doctorAssigned =
        TextEditingController(text: widget.patient.doctorAssigned);
    _gender = widget.patient.gender;
    _bloodGroup = widget.patient.bloodGroup;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Patient'),
        titleTextStyle: const TextStyle(color: Colors.white),
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
                    value: value,
                    child: Text(value,
                        style: const TextStyle(color: Colors.black)));
              }).toList(),
              onChanged: (newValue) => setState(() => _gender = newValue!),
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
                    value: value,
                    child: Text(value,
                        style: const TextStyle(color: Colors.black)));
              }).toList(),
              onChanged: (newValue) => setState(() => _bloodGroup = newValue!),
            ),
            TextField(
                controller: _bloodPressure,
                decoration: const InputDecoration(labelText: 'Blood Pressure')),
            TextField(
                controller: _condition,
                decoration: const InputDecoration(labelText: 'Condition')),
            TextField(
                controller: _doctorAssigned,
                decoration:
                    const InputDecoration(labelText: 'Assigned Doctor ID')),
            ElevatedButton(
              onPressed: () async {
                final updated = Patient(
                  id: widget.patient.id,
                  name: _name.text,
                  contact: _contact.text,
                  age: int.tryParse(_age.text) ?? widget.patient.age,
                  gender: _gender,
                  height:
                      double.tryParse(_height.text) ?? widget.patient.height,
                  weight:
                      double.tryParse(_weight.text) ?? widget.patient.weight,
                  bloodGroup: _bloodGroup,
                  bloodPressure: _bloodPressure.text,
                  condition: _condition.text,
                  doctorAssigned: _doctorAssigned.text,
                );
                await DatabaseHelper().updatePatient(updated);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Patient info updated',
                        style: TextStyle(color: Colors.white))));
                context.go('/admin');
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
