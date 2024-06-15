import 'package:cloud_firestore/cloud_firestore.dart';

class Gatepass {
  final String id;
  final String gatepassNo;
  final String initiatorName;
  final String initiatorID;
  final String date;
  final String materialName;
  final String quantity;
  final String reason;
  final String driverName;
  final String contact;
  final String driverID;
  final String deptDispatch;
  final String deptDelivery;
  final String gateNo;
  final String comments;
  final String status;
  final String userId;

  Gatepass({
    required this.id,
    required this.gatepassNo,
    required this.initiatorName,
    required this.initiatorID,
    required this.date,
    required this.materialName,
    required this.quantity,
    required this.reason,
    required this.driverName,
    required this.contact,
    required this.driverID,
    required this.deptDispatch,
    required this.deptDelivery,
    required this.gateNo,
    required this.comments,
    required this.status,
    required this.userId,
  });

  factory Gatepass.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return Gatepass(
      id: snapshot.id,
      gatepassNo: data['gatepassNo']?.toString() ?? '',
      initiatorName: data['initiatorName']?.toString() ?? '',
      initiatorID: data['initiatorID']?.toString() ?? '',
      date: data['date']?.toString() ?? '',
      materialName: data['materialName']?.toString() ?? '',
      quantity: data['quantity']?.toString() ?? '',
      reason: data['reason']?.toString() ?? '',
      driverName: data['driverName']?.toString() ?? '',
      contact: data['contact']?.toString() ?? '',
      driverID: data['driverID']?.toString() ?? '',
      deptDispatch: data['deptDispatch']?.toString() ?? '',
      deptDelivery: data['deptDelivery']?.toString() ?? '',
      gateNo: data['gateNo']?.toString() ?? '',
      comments: data['comments']?.toString() ?? '',
      status: data['status']?.toString() ?? '',
      userId: data['userId']?.toString() ?? '',
    );
  }
}
