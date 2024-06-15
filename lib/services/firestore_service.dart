import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/gatepass.dart';

class FirestoreService {
  final CollectionReference gatepassCollection =
      FirebaseFirestore.instance.collection('Gatepasses');

  Future<void> createGatepass(Gatepass gatepass) async {
    await gatepassCollection.add({
      'gatepassNo': gatepass.gatepassNo,
      'initiatorName': gatepass.initiatorName,
      'initiatorID': gatepass.initiatorID,
      'date': gatepass.date,
      'materialName': gatepass.materialName,
      'quantity': gatepass.quantity,
      'reason': gatepass.reason,
      'driverName': gatepass.driverName,
      'contact': gatepass.contact,
      'driverID': gatepass.driverID,
      'deptDispatch': gatepass.deptDispatch,
      'deptDelivery': gatepass.deptDelivery,
      'gateNo': gatepass.gateNo,
      'comments': gatepass.comments,
      'status': gatepass.status,
      'userId': gatepass.userId,
    });
  }

  Stream<QuerySnapshot> getGatepasses() {
    return gatepassCollection.snapshots();
  }

  Future<void> updateGatepassStatus(String id, String status) async {
    await gatepassCollection.doc(id).update({'status': status});
  }
}
