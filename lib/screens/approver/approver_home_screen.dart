import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/gatepass.dart';
import '../../services/firestore_service.dart';
import '../../services/notification_service.dart';

class ApproverHomeScreen extends StatelessWidget {
  final NotificationService _notificationService = NotificationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color.fromARGB(255, 19, 6, 71), // Set background color here
      body: Row(
        children: [
          // Left side: Image
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                'lib/assets/Gatepass_logo.png', // Path to your image asset
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Right side: Forms
          Expanded(
            flex: 1,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirestoreService().getGatepasses(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No gatepasses available'));
                }

                var gatepasses = snapshot.data!.docs
                    .map((doc) => Gatepass.fromSnapshot(doc))
                    .toList();

                return ListView.builder(
                  itemCount: gatepasses.length,
                  itemBuilder: (context, index) {
                    var gp = gatepasses[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: gp.status == 'Pending'
                              ? Color.fromARGB(255, 224, 142, 119)
                              : Color.fromARGB(255, 159, 187, 225),
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10.0,
                              spreadRadius: 2.0,
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(gp.gatepassNo),
                          subtitle: Text(gp.status),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Gatepass Details'),
                                  content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text('Material Name: ${gp.materialName}'),
                                      Text('Quantity: ${gp.quantity}'),
                                      Text('Dept Dispatch: ${gp.deptDispatch}'),
                                      Text('Dept Delivery: ${gp.deptDelivery}'),
                                      Text('Gate No: ${gp.gateNo}'),
                                      Text('Status: ${gp.status}'),
                                      Text(
                                          'Comments: ${gp.comments}'), // Assuming there's a comments field
                                    ],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        FirestoreService().updateGatepassStatus(
                                            gp.id, 'Approved');
                                        Navigator.of(context).pop();
                                        _notificationService.sendNotification(
                                          gp.userId,
                                          'Gatepass Approved',
                                          'Your gatepass ${gp.gatepassNo} has been approved',
                                        );
                                      },
                                      child: Text('Approve'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        FirestoreService().updateGatepassStatus(
                                            gp.id, 'Hold');
                                        Navigator.of(context).pop();
                                        _notificationService.sendNotification(
                                          gp.userId,
                                          'Gatepass on Hold',
                                          'Your gatepass ${gp.gatepassNo} is on hold',
                                        );
                                      },
                                      child: Text('Hold'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        FirestoreService().updateGatepassStatus(
                                            gp.id, 'Rejected');
                                        Navigator.of(context).pop();
                                        _notificationService.sendNotification(
                                          gp.userId,
                                          'Gatepass Rejected',
                                          'Your gatepass ${gp.gatepassNo} has been rejected',
                                        );
                                      },
                                      child: Text('Reject'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
