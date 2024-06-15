import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/gatepass.dart';
import '../../services/firestore_service.dart';

class SecurityScreen extends StatefulWidget {
  @override
  _SecurityScreenState createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  Map<String, bool> printedStatus = {};
  Map<String, DateTime> firstDisplayedTime = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color:
            Color.fromARGB(255, 5, 2, 35), // Background color set to dark grey
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding from all sides
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0), // Padding for the image
                  child: Image.asset(
                    'lib/assets/Gatepass_logo.png', // Path to your image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0), // Padding for the forms
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirestoreService().getGatepasses(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      var gatepasses = snapshot.data!.docs
                          .map((doc) => Gatepass.fromSnapshot(doc))
                          .toList();

                      // Update firstDisplayedTime for new gatepasses
                      for (var gp in gatepasses) {
                        if (!firstDisplayedTime.containsKey(gp.gatepassNo)) {
                          firstDisplayedTime[gp.gatepassNo] = DateTime.now();
                        }
                      }

                      return ListView.builder(
                        itemCount: gatepasses.length,
                        itemBuilder: (context, index) {
                          var gp = gatepasses[index];
                          final isPrinted =
                              printedStatus[gp.gatepassNo] ?? false;

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: GatePassListItem(
                              gatePass: gp,
                              isPrinted: isPrinted,
                              onApprove: () {
                                // Implement your approve logic here
                                // For example, update the gate pass status to 'Approved' in Firestore
                              },
                              onPrint: () {
                                if (gp.status == 'Rejected') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Cannot be printed')),
                                  );
                                } else if (gp.status == 'Hold') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Still in hold')),
                                  );
                                } else {
                                  setState(() {
                                    printedStatus[gp.gatepassNo] = true;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Gatepass printed successfully')),
                                  );
                                }
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GatePassListItem extends StatelessWidget {
  final Gatepass gatePass;
  final bool isPrinted;
  final VoidCallback onApprove;
  final VoidCallback onPrint;

  const GatePassListItem({
    required this.gatePass,
    required this.isPrinted,
    required this.onApprove,
    required this.onPrint,
  });

  @override
  Widget build(BuildContext context) {
    Color cardColor;

    if (isPrinted) {
      cardColor = Color.fromARGB(255, 83, 169, 89);
    } else {
      switch (gatePass.status) {
        case 'Approved':
          cardColor = Color.fromARGB(255, 244, 246, 244); // Green for approved
          break;
        case 'Rejected':
          cardColor = Color.fromARGB(255, 219, 104, 95); // Red for rejected
          break;
        case 'Hold':
          cardColor = Color.fromARGB(255, 68, 121, 163); // Blue for hold
          break;
        default:
          cardColor = Colors.white; // Default to white for other statuses
          break;
      }
    }

    return Card(
      elevation: 4.0,
      color: cardColor,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5, // Adjust the width
        child: ListTile(
          title: Text(gatePass.gatepassNo),
          subtitle: Text(gatePass.status),
          onTap: () {
            if (gatePass.status == 'Approved') {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Gatepass Details'),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Material Name: ${gatePass.materialName}'),
                        Text('Quantity: ${gatePass.quantity}'),
                        Text('Dept Dispatch: ${gatePass.deptDispatch}'),
                        Text('Dept Delivery: ${gatePass.deptDelivery}'),
                        Text('Gate No: ${gatePass.gateNo}'),
                        Text('Status: ${gatePass.status}'),
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          // Implement print functionality
                          onPrint();
                          Navigator.of(context).pop();
                        },
                        child: Text('Print Gatepass'),
                      ),
                    ],
                  );
                },
              );
            } else {
              if (gatePass.status == 'Rejected') {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Cannot be printed')),
                );
              } else if (gatePass.status == 'Hold') {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Still in hold')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Gatepass is not approved')),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
