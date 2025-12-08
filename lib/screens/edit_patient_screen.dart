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
  late TextEditingController _address;
  late TextEditingController _emergencyContact;
  late TextEditingController _insurance;

  late String _gender;
  late String _bloodGroup;
  late String _department;
  late String _status;

  final _formKey = GlobalKey<FormState>();

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
    _address = TextEditingController(text: widget.patient.address);
    _emergencyContact =
        TextEditingController(text: widget.patient.emergencyContact);
    _insurance = TextEditingController(text: widget.patient.insurance);
    _gender = widget.patient.gender;
    _bloodGroup = widget.patient.bloodGroup;
    _department = widget.patient.department;
    _status = widget.patient.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Patient'),
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
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) => value!.isEmpty ? 'Required' : null),
              SizedBox(height: 8),
              TextFormField(
                  controller: _contact,
                  decoration: const InputDecoration(labelText: 'Contact'),
                  validator: (value) => value!.isEmpty ? 'Required' : null),
              SizedBox(height: 8),
              TextFormField(
                  controller: _age,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Age'),
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
                onChanged: (newValue) => setState(() => _gender = newValue!),
              ),
              SizedBox(height: 8),
              TextFormField(
                  controller: _height,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Height (cm)'),
                  validator: (value) => double.tryParse(value!) == null
                      ? 'Invalid number'
                      : null),
              SizedBox(height: 8),
              TextFormField(
                  controller: _weight,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Weight (kg)'),
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
                onChanged: (newValue) =>
                    setState(() => _bloodGroup = newValue!),
              ),
              SizedBox(height: 8),
              TextFormField(
                  controller: _bloodPressure,
                  decoration:
                      const InputDecoration(labelText: 'Blood Pressure'),
                  validator: (value) => value!.isEmpty ? 'Required' : null),
              SizedBox(height: 8),
              TextFormField(
                  controller: _condition,
                  decoration: const InputDecoration(labelText: 'Condition'),
                  validator: (value) => value!.isEmpty ? 'Required' : null),
              SizedBox(height: 8),
              TextFormField(
                  controller: _doctorAssigned,
                  decoration:
                      const InputDecoration(labelText: 'Assigned Doctor ID'),
                  validator: (value) => value!.isEmpty ? 'Required' : null),
              SizedBox(height: 8),
              TextFormField(
                  controller: _address,
                  decoration: const InputDecoration(labelText: 'Address'),
                  validator: (value) => value!.isEmpty ? 'Required' : null),
              SizedBox(height: 8),
              TextFormField(
                  controller: _emergencyContact,
                  decoration:
                      const InputDecoration(labelText: 'Emergency Contact'),
                  validator: (value) => value!.isEmpty ? 'Required' : null),
              SizedBox(height: 8),
              TextFormField(
                  controller: _insurance,
                  decoration: const InputDecoration(labelText: 'Insurance'),
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
                onChanged: (newValue) =>
                    setState(() => _department = newValue!),
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
                onChanged: (newValue) => setState(() => _status = newValue!),
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                icon: Icon(Icons.edit),
                label: const Text('Update'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final updated = Patient(
                      id: widget.patient.id,
                      name: _name.text,
                      contact: _contact.text,
                      age: int.tryParse(_age.text) ?? widget.patient.age,
                      gender: _gender,
                      height: double.tryParse(_height.text) ??
                          widget.patient.height,
                      weight: double.tryParse(_weight.text) ??
                          widget.patient.weight,
                      bloodGroup: _bloodGroup,
                      bloodPressure: _bloodPressure.text,
                      condition: _condition.text,
                      doctorAssigned: _doctorAssigned.text,
                      address: _address.text,
                      emergencyContact: _emergencyContact.text,
                      insurance: _insurance.text,
                      department: _department,
                      status: _status,
                    );
                    await DatabaseHelper().updatePatient(updated);
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
