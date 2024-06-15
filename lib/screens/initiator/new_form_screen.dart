import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'create_gatepass_screen.dart';
import 'view_gatepasses_screen.dart';

class NewFormScreen extends StatelessWidget {
  final User user;

  NewFormScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'lib/assets/Gatepass_wallpaper.jpg', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          // Foreground content
          Positioned(
            top: 40, // Distance from the top of the screen
            right: 20, // Distance from the right of the screen
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CreateGatepassScreen(user: user)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color.fromARGB(255, 234, 172, 150), // Button color
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 30),
                    textStyle: TextStyle(fontSize: 25),
                  ),
                  child: Text('Add New'),
                ),
                SizedBox(height: 30), // Space between the buttons
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ViewGatepassesScreen(user: user)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color.fromARGB(255, 145, 173, 229), // Button color
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 30),
                    textStyle: TextStyle(fontSize: 25),
                  ),
                  child: Text('View Gate Passes'),
                ),
              ],
            ),
          ),
          // Back Button
          Positioned(
            bottom: 10, // Distance from the bottom of the screen
            left: 10, // Distance from the left of the screen
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the previous screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color.fromARGB(255, 244, 237, 237), // Button color
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle: TextStyle(fontSize: 16),
              ),
              child: Text('Back'),
            ),
          ),
        ],
      ),
    );
  }
}
