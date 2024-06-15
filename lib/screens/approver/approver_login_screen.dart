// approver_login_screen.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../login_screen.dart';
import 'approver_home_screen.dart';

class ApproverLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginScreen(onLogin: (User? user) {
      if (user != null) {
        // Implement login logic here, such as navigation
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ApproverHomeScreen()),
        );
      } else {
        // Handle login failure
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed')),
        );
      }
    });
  }
}
