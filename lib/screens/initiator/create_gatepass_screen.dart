import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/gatepass.dart';
import '../../services/firestore_service.dart';
import 'new_form_screen.dart';

class CreateGatepassScreen extends StatefulWidget {
  final User user;

  CreateGatepassScreen({required this.user});

  @override
  _CreateGatepassScreenState createState() => _CreateGatepassScreenState();
}

class _CreateGatepassScreenState extends State<CreateGatepassScreen> {
  final _formKey = GlobalKey<FormState>();
  String gatepassNo = '';
  String initiatorName = '';
  String initiatorID = '';
  String date = '';
  String materialName = '';
  String quantity = '';
  String reason = '';
  String driverName = '';
  String contact = '';
  String driverID = '';
  String deptDispatch = '';
  String deptDelivery = '';
  String gateNo = '';
  String comments = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 3, 33, 53),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 170, 208, 240),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Create Gatepass',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black45,
                            offset: Offset(1.0, 1.0),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              buildTextField('Gatepass No',
                                  (value) => gatepassNo = value!),
                              buildTextField('Initiator Name',
                                  (value) => initiatorName = value!),
                              buildTextField('Initiator ID',
                                  (value) => initiatorID = value!),
                              buildTextField('Date', (value) => date = value!),
                              buildTextField('Material Name',
                                  (value) => materialName = value!),
                              buildTextField(
                                  'Quantity', (value) => quantity = value!),
                              buildTextField(
                                  'Reason', (value) => reason = value!),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              buildTextField('Driver Name',
                                  (value) => driverName = value!),
                              buildTextField(
                                  'Contact', (value) => contact = value!),
                              buildTextField(
                                  'Driver ID', (value) => driverID = value!),
                              buildTextField('Department of Dispatch',
                                  (value) => deptDispatch = value!),
                              buildTextField('Department of Delivery',
                                  (value) => deptDelivery = value!),
                              buildTextField(
                                  'Gate No', (value) => gateNo = value!),
                              buildTextField(
                                  'Comments', (value) => comments = value!),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _formKey.currentState!.save();
                        FirestoreService().createGatepass(
                          Gatepass(
                            id: '',
                            gatepassNo: gatepassNo,
                            initiatorName: initiatorName,
                            initiatorID: initiatorID,
                            date: date,
                            materialName: materialName,
                            quantity: quantity,
                            reason: reason,
                            driverName: driverName,
                            contact: contact,
                            driverID: driverID,
                            deptDispatch: deptDispatch,
                            deptDelivery: deptDelivery,
                            gateNo: gateNo,
                            comments: comments,
                            status: 'Pending',
                            userId: widget.user.uid,
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Gatepass created successfully')),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                NewFormScreen(user: widget.user),
                          ),
                        );
                      },
                      child: Container(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 4, 1, 31),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, FormFieldSetter<String> onSaved) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onSaved: onSaved,
      ),
    );
  }
}
