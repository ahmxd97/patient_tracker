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
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Patient Information',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 16),
                      _buildInfoRow(
                          'ID', widget.patient.id?.toString() ?? 'N/A'),
                      _buildInfoRow('Age', '${widget.patient.age} years'),
                      _buildInfoRow('Contact', widget.patient.contact),
                      _buildInfoRow('Gender', widget.patient.gender),
                      _buildInfoRow('Height', '${widget.patient.height} cm'),
                      _buildInfoRow('Weight', '${widget.patient.weight} kg'),
                      _buildInfoRow('Blood Group', widget.patient.bloodGroup),
                      _buildInfoRow(
                          'Blood Pressure', widget.patient.bloodPressure),
                      _buildInfoRow('Condition', widget.patient.condition),
                      _buildInfoRow(
                          'Assigned Doctor', widget.patient.doctorAssigned),
                      _buildInfoRow('Address', widget.patient.address),
                      _buildInfoRow(
                          'Emergency Contact', widget.patient.emergencyContact),
                      _buildInfoRow('Insurance', widget.patient.insurance),
                      _buildInfoRow('Department', widget.patient.department),
                      _buildInfoRow('Status', widget.patient.status),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(height: 32, thickness: 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Medical History',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 8),
            _records.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'No medical history recorded yet.',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _records.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 16),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            _records[index].note,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF231F20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _note,
                          decoration: const InputDecoration(
                            labelText: 'Add Medical Note',
                            hintText: 'Enter note here...',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 3,
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text('Add'),
                        onPressed: () async {
                          if (widget.patient.id != null &&
                              _note.text.isNotEmpty) {
                            final record = Record(
                              patientId: widget.patient.id!,
                              note: _note.text,
                            );
                            await DatabaseHelper().insertRecord(record);
                            _note.clear();
                            _loadRecords();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Note added successfully'),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Color(0xFF231F20),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF231F20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
