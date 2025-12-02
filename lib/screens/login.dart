import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'package:go_router/go_router.dart';
import '../models/user.dart';

class LoginScreen extends StatelessWidget {
  final _email = TextEditingController();
  final _pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Card(
            elevation: 8,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Patient Tracker System',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  TextField(
                      controller: _email,
                      decoration: const InputDecoration(
                          labelText: 'Email', border: OutlineInputBorder())),
                  const SizedBox(height: 8),
                  TextField(
                      controller: _pass,
                      obscureText: true,
                      decoration: const InputDecoration(
                          labelText: 'Password', border: OutlineInputBorder())),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final auth =
                          Provider.of<AuthProvider>(context, listen: false);
                      if (auth.login(_email.text, _pass.text)) {
                        context
                            .go(auth.role == Role.admin ? '/admin' : '/doctor');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Invalid credentials')));
                      }
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
