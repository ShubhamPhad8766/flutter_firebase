// ignore_for_file: await_only_futures

import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethod {
  Future addEmpDetails(Map<String, dynamic> employeeInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Employee")
        .doc(id)
        .set(employeeInfoMap);
  }

  Future<Stream<QuerySnapshot>> getEmployeeDetails() async {
    return await FirebaseFirestore.instance.collection("Employee").snapshots();
  }

  Future updateEmployeeDetails(
      String id, Map<String, dynamic> updateInfo) async {
    return FirebaseFirestore.instance
        .collection("Employee")
        .doc(id)
        .update(updateInfo);
  }

  Future deleteEmployeeDetails(
    String id,
  ) async {
    return FirebaseFirestore.instance.collection("Employee").doc(id).delete();
  }
}
