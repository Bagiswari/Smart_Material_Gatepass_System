import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/gatepass.dart';
import '../../services/firestore_service.dart';

class ViewGatepassesScreen extends StatelessWidget {
  final User user;

  ViewGatepassesScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color.fromARGB(255, 35, 7, 45), // Set background color here
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirestoreService().getGatepasses(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            var gatepasses = snapshot.data!.docs
                .map((doc) => Gatepass.fromSnapshot(doc))
                .toList();
            return Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
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
              child: DataTable(
                columns: const <DataColumn>[
                  DataColumn(label: Text('Gatepass ID')),
                  DataColumn(label: Text('Material Name')),
                  DataColumn(label: Text('Quantity')),
                  DataColumn(label: Text('Dept Dispatch')),
                  DataColumn(label: Text('Dept Delivery')),
                  DataColumn(label: Text('Gate No')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: gatepasses.map((gp) {
                  return DataRow(
                    cells: <DataCell>[
                      DataCell(Text(gp.gatepassNo)),
                      DataCell(Text(gp.materialName)),
                      DataCell(Text(gp.quantity)),
                      DataCell(Text(gp.deptDispatch)),
                      DataCell(Text(gp.deptDelivery)),
                      DataCell(Text(gp.gateNo)),
                      DataCell(Text(gp.status)),
                      DataCell(Row(
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(FontAwesomeIcons.penToSquare),
                            onPressed: () {
                              // Implement edit functionality
                            },
                          ),
                          IconButton(
                            icon: const Icon(FontAwesomeIcons.xmark),
                            onPressed: () {
                              // Implement delete functionality
                            },
                          ),
                        ],
                      )),
                    ],
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
