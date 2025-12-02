import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../db/database.dart';
import '../models/patient.dart';
import '../providers/auth_provider.dart';
import 'package:go_router/go_router.dart';

class DoctorDashboard extends StatefulWidget {
  @override
  _DoctorDashboardState createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  List<Patient> _patients = [];
  List<Patient> _filtered = [];
  final _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPatients();
    _search.addListener(_filter);
  }

  Future<void> _loadPatients() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final patients = await DatabaseHelper().getPatients();
    setState(() {
      _patients =
          patients.where((p) => p.doctorAssigned == auth.userId).toList();
      _filtered = _patients;
    });
  }

  void _filter() {
    final query = _search.text.toLowerCase();
    setState(() {
      _filtered = _patients
          .where((p) =>
              p.name.toLowerCase().contains(query) ||
              p.contact.contains(query) ||
              (p.id?.toString().contains(query) ?? false))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Dashboard'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                title: Text(auth.userName ?? '',
                    style: const TextStyle(color: Colors.black)),
                subtitle: Text(
                    'ID: ${auth.userId ?? ''} | Title: ${auth.userTitle ?? ''}',
                    style: const TextStyle(color: Colors.black)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _search,
              decoration:
                  const InputDecoration(labelText: 'Search by Name/ID/Contact'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filtered.length,
              itemBuilder: (context, index) {
                final p = _filtered[index];
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
                      subtitle: Text('ID: ${p.id ?? ''} | Age: ${p.age}',
                          style: const TextStyle(color: Colors.white)),
                      onTap: () => context.go('/patient_details', extra: p),
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
