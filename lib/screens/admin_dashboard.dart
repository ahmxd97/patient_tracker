import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../db/database.dart';
import '../models/patient.dart';
import '../providers/auth_provider.dart';
import 'package:go_router/go_router.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  List<Patient> _patients = [];

  @override
  void initState() {
    super.initState();
    _loadPatients();
  }

  Future<void> _loadPatients() async {
    final patients = await DatabaseHelper().getPatients();
    setState(() => _patients = patients);
  }

  Future<void> _printPatients() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Table.fromTextArray(
            headers: [
              'ID',
              'Name',
              'Contact',
              'Age',
              'Gender',
              'Height',
              'Weight',
              'Blood Group',
              'Blood Pressure',
              'Condition',
              'Doctor Assigned'
            ],
            data: _patients
                .map((p) => [
                      p.id.toString(),
                      p.name,
                      p.contact,
                      p.age.toString(),
                      p.gender,
                      p.height.toString(),
                      p.weight.toString(),
                      p.bloodGroup,
                      p.bloodPressure,
                      p.condition,
                      p.doctorAssigned,
                    ])
                .toList(),
          );
        },
      ),
    );
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.go('/add_patient'),
          ),
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: _printPatients,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              auth.logout();
              context.go('/');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                title: Text(auth.userName ?? '',
                    style: const TextStyle(color: Colors.white)),
                subtitle: Text(
                    'ID: ${auth.userId ?? ''} | Title: ${auth.userTitle ?? ''} | Number of Patients: ${_patients.length}',
                    style: const TextStyle(color: Colors.black)),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _patients.length,
              itemBuilder: (context, index) {
                final p = _patients[index];
                return Padding(
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
                    child: ListTile(
                      title: Text(p.name,
                          style: const TextStyle(color: Colors.white)),
                      subtitle: Text(
                          'ID: ${p.id ?? ''} | Age: ${p.age} | Contact: ${p.contact} | Doctor: ${p.doctorAssigned}',
                          style: const TextStyle(color: Colors.white)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () =>
                                context.go('/edit_patient', extra: p),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              if (p.id != null) {
                                await DatabaseHelper().deletePatient(p.id!);
                                _loadPatients();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
