import 'package:flutter/material.dart';
import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  Role? role;
  String? userName;
  String? userId;
  String? userTitle;

  bool login(String email, String pass) {
    if (email == 'admin@ex.com' && pass == 'admin') {
      role = Role.admin;
      userName = 'Admin User';
      userId = 'A001';
      userTitle = 'Administrator';
      notifyListeners();
      return true;
    } else if (email == 'doctor@ex.com' && pass == 'doctor') {
      role = Role.doctor;
      userName = 'Dr. John Doe';
      userId = 'D001';
      userTitle = 'Physician';
      notifyListeners();
      return true;
    } else if (email == 'doctor2@ex.com' && pass == 'doctor2') {
      role = Role.doctor;
      userName = 'Dr. Jane Smith';
      userId = 'D002';
      userTitle = 'Physician';
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    role = null;
    userName = null;
    userId = null;
    userTitle = null;
    notifyListeners();
  }
}
