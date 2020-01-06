import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:intl/intl.dart';

class FirebaseFirestoreUtil {

  static final FirebaseFirestoreUtil _instance = new FirebaseFirestoreUtil.internal();

  Firestore _firestoreInstance = Firestore.instance;

  FirebaseFirestoreUtil.internal();

  String _uniqueDeviceIdentifier = 'Unknown';

  factory FirebaseFirestoreUtil() {
    return _instance;
  }

  initState() async {
    await initUniqueIdentifierState();

    var counter = 0;
    await _firestoreInstance.collection("users")
        .document(_uniqueDeviceIdentifier)
        .collection("smoke_counters").where("date", isGreaterThanOrEqualTo: DateTime.parse(new DateFormat('yyyyMMdd').format(new DateTime.now())))
        .getDocuments().then((snapshot) {
      snapshot.documents.forEach((document) async {
        counter = counter + document.data['counter'];
      });
    });

    return counter;
  }

  createCounter(counter) async {
    await _firestoreInstance.collection("users").document(_uniqueDeviceIdentifier).collection("smoke_counters").document().setData({'counter': 1, 'date': new DateTime.now()});
  }

  Future<void> initUniqueIdentifierState() async {
    String identifier;
    try {
      identifier = await UniqueIdentifier.serial;
    } on Exception {
      identifier = 'Failed to get Unique Identifier';
    }

    _uniqueDeviceIdentifier = identifier;
  }
}
