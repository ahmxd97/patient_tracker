// lib/screens/patient_details_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../db/database.dart';
import '../models/patient.dart';
import '../models/record.dart';
import '../providers/auth_provider.dart';
import 'package:go_router/go_router.dart';

class PatientDetailsScreen extends StatefulWidget {
  final Patient patient;

  const PatientDetailsScreen({super.key, required this.patient});

  @override
  _PatientDetailsScreenState createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
  List<Record> _records = [];
  final _note = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  Future<void> _loadRecords() async {
    if (widget.patient.id != null) {
      final records = await DatabaseHelper().getRecords(widget.patient.id!);
      setState(() => _records = records);
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.patient.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/doctor'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              auth.logout();
              context.go('/');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ID: ${widget.patient.id ?? ''}'),
                  Text(
                      'Age: ${widget.patient.age}, Contact: ${widget.patient.contact}'),
                  Text('Gender: ${widget.patient.gender}'),
                  Text('Height: ${widget.patient.height} cm'),
                  Text('Weight: ${widget.patient.weight} kg'),
                  Text('Blood Group: ${widget.patient.bloodGroup}'),
                  Text('Blood Pressure: ${widget.patient.bloodPressure}'),
                  Text('Condition: ${widget.patient.condition}'),
                  Text('Assigned Doctor: ${widget.patient.doctorAssigned}'),
                  Text('Address: ${widget.patient.address}'),
                  Text('Emergency Contact: ${widget.patient.emergencyContact}'),
                  Text('Insurance: ${widget.patient.insurance}'),
                  Text('Department: ${widget.patient.department}'),
                  Text('Status: ${widget.patient.status}'),
                ],
              ),
            ),
            const Divider(),
            const Text('Medical History:'),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _records.length,
              itemBuilder: (context, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF000000),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(title: Text(_records[index].note)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _note,
                      decoration: const InputDecoration(labelText: 'Add Note'),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (widget.patient.id != null && _note.text.isNotEmpty) {
                        final record = Record(
                          patientId: widget.patient.id!,
                          note: _note.text,
                        );
                        await DatabaseHelper().insertRecord(record);
                        _note.clear();
                        _loadRecords();
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
