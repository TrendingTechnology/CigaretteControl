import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unique_identifier/unique_identifier.dart';

class FirebaseFirestoreUtil {
  int _counter;

  static final FirebaseFirestoreUtil _instance = new FirebaseFirestoreUtil.internal();

  Firestore _firestoreInstance;

  FirebaseFirestoreUtil.internal();

  String _uniqueDeviceIdentifier = 'Unknown';

  factory FirebaseFirestoreUtil() {
    return _instance;
  }

  Future<int> initState() async {
    await initUniqueIdentifierState();

    _firestoreInstance = Firestore.instance;
    var smokeCounters = _firestoreInstance
        .collection("smoke_counters")
        .document(_uniqueDeviceIdentifier);

    if (smokeCounters == null) {}

    return smokeCounters;
  }

  Future<DailySmokeCounter> createDailySmokeCounter(
      String title, String description) async {

    var createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx
          .get(_firestoreInstance.collection('smoke_counters').document(_uniqueDeviceIdentifier));

      var dataMap = new Map<String, dynamic>();
      dataMap['counter'] = 0;
      dataMap['date'] = new DateTime.now();

      await tx.set(ds.reference, dataMap);

      return dataMap;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return DailySmokeCounter.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  increment() async {
    var smokeCounters = _firestoreInstance
        .collection("smoke_counters")
        .document(_uniqueDeviceIdentifier);

    var createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx
          .get(_firestoreInstance.collection('smoke_counters').document(_uniqueDeviceIdentifier));

      var dataMap = new Map<String, dynamic>();
      dataMap['counter'] = smokeCounters;
      dataMap['date'] = new DateTime.now();

      await tx.set(ds.reference, dataMap);

      return dataMap;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return DailySmokeCounter.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  int getCounter() {
    return _counter;
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

class DailySmokeCounter {
  static Future<DailySmokeCounter> fromMap(Map<String, dynamic> mapData) {}
}
