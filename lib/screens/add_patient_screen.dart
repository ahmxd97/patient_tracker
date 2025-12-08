import 'package:flutter/material.dart';
import 'package:patient_tracker/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import '../db/database.dart';
import '../models/patient.dart';
import 'package:go_router/go_router.dart';

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
  final _address = TextEditingController();
  final _emergencyContact = TextEditingController();
  final _insurance = TextEditingController();

  String? _gender;
  String? _bloodGroup;
  String? _department;
  String? _status;

  final _formKey = GlobalKey<FormState>();

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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                  controller: _name,
                  decoration: const InputDecoration(
                      labelText: 'Name', hintText: 'e.g., John Doe'),
                  validator: (value) => value!.isEmpty ? 'Required' : null),
              SizedBox(height: 8),
              TextFormField(
                  controller: _contact,
                  decoration: const InputDecoration(
                      labelText: 'Contact', hintText: 'e.g., 1234567890'),
                  validator: (value) => value!.isEmpty ? 'Required' : null),
              SizedBox(height: 8),
              TextFormField(
                  controller: _age,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Age', hintText: 'e.g., 30'),
                  validator: (value) =>
                      int.tryParse(value!) == null ? 'Invalid number' : null),
              SizedBox(height: 8),
              DropdownButton<String>(
                value: _gender,
                hint: const Text('Gender'),
                items: ['Male', 'Female', 'Others'].map((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
                onChanged: (newValue) => setState(() => _gender = newValue),
              ),
              SizedBox(height: 8),
              TextFormField(
                  controller: _height,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Height (cm)', hintText: 'e.g., 170.5'),
                  validator: (value) => double.tryParse(value!) == null
                      ? 'Invalid number'
                      : null),
              SizedBox(height: 8),
              TextFormField(
                  controller: _weight,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Weight (kg)', hintText: 'e.g., 65.0'),
                  validator: (value) => double.tryParse(value!) == null
                      ? 'Invalid number'
                      : null),
              SizedBox(height: 8),
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
              SizedBox(height: 8),
              TextFormField(
                  controller: _bloodPressure,
                  decoration: const InputDecoration(
                      labelText: 'Blood Pressure', hintText: 'e.g., 120/80'),
                  validator: (value) => value!.isEmpty ? 'Required' : null),
              SizedBox(height: 8),
              TextFormField(
                  controller: _condition,
                  decoration: const InputDecoration(
                      labelText: 'Condition', hintText: 'e.g., Hypertension'),
                  validator: (value) => value!.isEmpty ? 'Required' : null),
              SizedBox(height: 8),
              TextFormField(
                  controller: _doctorAssigned,
                  decoration: const InputDecoration(
                      labelText: 'Assigned Doctor ID', hintText: 'e.g., D001'),
                  validator: (value) => value!.isEmpty ? 'Required' : null),
              SizedBox(height: 8),
              TextFormField(
                  controller: _address,
                  decoration: const InputDecoration(
                      labelText: 'Address', hintText: 'e.g., 123 Main St'),
                  validator: (value) => value!.isEmpty ? 'Required' : null),
              SizedBox(height: 8),
              TextFormField(
                  controller: _emergencyContact,
                  decoration: const InputDecoration(
                      labelText: 'Emergency Contact',
                      hintText: 'e.g., 9876543210'),
                  validator: (value) => value!.isEmpty ? 'Required' : null),
              SizedBox(height: 8),
              TextFormField(
                  controller: _insurance,
                  decoration: const InputDecoration(
                      labelText: 'Insurance', hintText: 'e.g., ABC Insurance'),
                  validator: (value) => value!.isEmpty ? 'Required' : null),
              SizedBox(height: 8),
              DropdownButton<String>(
                value: _department,
                hint: const Text('Department'),
                items: ['Emergency', 'Elective Direct', 'Observation']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
                onChanged: (newValue) => setState(() => _department = newValue),
              ),
              SizedBox(height: 8),
              DropdownButton<String>(
                value: _status,
                hint: const Text('Status'),
                items: [
                  'Waiting',
                  'Appointment',
                  'Surgery',
                  'After Care',
                  'Transferring'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
                onChanged: (newValue) => setState(() => _status = newValue),
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                icon: Icon(Icons.person_add),
                label: const Text('Save'),
                onPressed: () async {
                  if (_formKey.currentState!.validate() &&
                      _gender != null &&
                      _bloodGroup != null &&
                      _department != null &&
                      _status != null) {
                    final patient = Patient(
                      name: _name.text,
                      contact: _contact.text,
                      age: int.parse(_age.text),
                      gender: _gender!,
                      height: double.parse(_height.text),
                      weight: double.parse(_weight.text),
                      bloodGroup: _bloodGroup!,
                      bloodPressure: _bloodPressure.text,
                      condition: _condition.text,
                      doctorAssigned: _doctorAssigned.text,
                      address: _address.text,
                      emergencyContact: _emergencyContact.text,
                      insurance: _insurance.text,
                      department: _department!,
                      status: _status!,
                    );
                    await DatabaseHelper().insertPatient(patient);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Patient info saved',
                            style: TextStyle(color: Colors.white))));
                    context.go('/admin');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
