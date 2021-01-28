import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jitney_userSide/models/driver.dart';

class DriverService{
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String collection = 'locations';

  Stream<List<DriverModel>> getDrivers() {
    return _firestore
        .collection(collection)
        .snapshots()
        .map((event) => event.docs.map((e) => DriverModel.fromSnapshot(e))
        .toList());
  }
}