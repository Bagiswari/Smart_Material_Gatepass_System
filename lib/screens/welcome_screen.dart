import 'package:flutter/material.dart';

import 'approver/approver_home_screen.dart';
import 'initiator/new_form_screen.dart';
import 'login_screen.dart';
import 'security/security_screen.dart'; // Ensure correct import

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _showWelcomeBox = false;

  @override
  void initState() {
    super.initState();
    _showWelcomeBoxWithDelay();
  }

  void _showWelcomeBoxWithDelay() {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _showWelcomeBox = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'lib/assets/Bg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Foreground content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 70), // Space from the top
                // Welcome Box with animation
                Align(
                  alignment: Alignment.topCenter,
                  child: AnimatedOpacity(
                    duration: Duration(seconds: 1),
                    opacity: _showWelcomeBox ? 1 : 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 228, 209, 103),
                        borderRadius:
                            BorderRadius.circular(10), // Reduced curveness
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // Changes position of shadow
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Welcome to Smart Material Gate Pass System',
                            style: TextStyle(fontSize: 24),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                              height: 10), // Space between welcome and subtitle
                          Text(
                            'Seamless Entry, Smart Security – Your Gatepass, Reimagined',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                              height:
                                  50), // Increased space between text and button
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RoleSelectionScreen()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 243, 182,
                                  97), // Change button background color
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              textStyle: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 9, 0,
                                    0), // Change text font color to white
                              ),
                              elevation: 5,
                              shadowColor: Colors.black.withOpacity(0.5),
                            ),
                            child: Text('Start'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RoleSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "lib/assets/Gatepass_wallpaper.jpg"), // Change to your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Buttons at top right
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 50, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(onLogin: (user) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NewFormScreen(user: user!)),
                              );
                            }),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 80.0, // Keep horizontal padding
                          vertical: 40.0, // Keep vertical padding
                        ),
                        backgroundColor:
                            Color.fromARGB(255, 168, 185, 239), // Button color
                      ),
                      child: Text(
                        'Initiator',
                        style: TextStyle(fontSize: 25.0), // Increase text size
                      ),
                    ),
                    SizedBox(height: 20.0), // Add space between buttons
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(onLogin: (user) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ApproverHomeScreen()),
                              );
                            }),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 74.0, // Keep horizontal padding
                          vertical: 40.0, // Keep vertical padding
                        ),
                        backgroundColor:
                            Color.fromARGB(255, 167, 223, 180), // Button color
                      ),
                      child: Text(
                        'Approver',
                        style: TextStyle(fontSize: 25.0), // Increase text size
                      ),
                    ),
                    SizedBox(height: 20.0), // Add space between buttons
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SecurityScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 80.0, // Keep horizontal padding
                          vertical: 40.0, // Keep vertical padding
                        ),
                        backgroundColor:
                            Color.fromARGB(255, 222, 166, 111), // Button color
                      ),
                      child: Text(
                        'Security',
                        style: TextStyle(fontSize: 25.0), // Increase text size
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Back Button
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 15.0,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                          width: 3.0), // Add space between the icon and text
                      Text('Back'),
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
}
