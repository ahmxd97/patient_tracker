import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'screens/login.dart';
import 'screens/admin_dashboard.dart';
import 'screens/doctor_dashboard.dart';
import 'screens/add_patient_screen.dart';
import 'screens/edit_patient_screen.dart';
import 'screens/patient_details_screen.dart';
import 'models/user.dart';
import 'models/patient.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => LoginScreen()),
    GoRoute(
      path: '/admin',
      builder: (context, state) => AdminDashboard(),
      redirect: (context, state) {
        final auth = Provider.of<AuthProvider>(context, listen: false);
        return auth.role == Role.admin ? null : '/';
      },
    ),
    GoRoute(
      path: '/doctor',
      builder: (context, state) => DoctorDashboard(),
      redirect: (context, state) {
        final auth = Provider.of<AuthProvider>(context, listen: false);
        return auth.role == Role.doctor ? null : '/';
      },
    ),
    GoRoute(
        path: '/add_patient', builder: (context, state) => AddPatientScreen()),
    GoRoute(
        path: '/edit_patient',
        builder: (context, state) =>
            EditPatientScreen(patient: state.extra as Patient)),
    GoRoute(
        path: '/patient_details',
        builder: (context, state) =>
            PatientDetailsScreen(patient: state.extra as Patient)),
  ],
);
