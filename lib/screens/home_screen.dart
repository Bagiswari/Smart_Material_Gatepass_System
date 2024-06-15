import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'approver/approver_login_screen.dart';
import 'initiator/new_form_screen.dart';
import 'security/security_screen.dart'; // Ensure correct import

class HomeScreen extends StatelessWidget {
  final User user;

  HomeScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'lib/assets/ISI_wallpaper.jpg'), // Add your image asset here
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewFormScreen(user: user)),
                  );
                },
                child: Text('Initiator'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ApproverLoginScreen()),
                  );
                },
                child: Text('Approver'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SecurityScreen()), // Use SecurityScreen here
                  );
                },
                child: Text('Security'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
