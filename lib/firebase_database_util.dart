import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

class FirebaseDatabaseUtil {
  DatabaseReference _counterRef;
  StreamSubscription<Event> _counterSubscription;
  StreamSubscription<Event> _messagesSubscription;
  FirebaseDatabase database = new FirebaseDatabase();
  int _counter;
  DatabaseError error;

  static final FirebaseDatabaseUtil _instance = new FirebaseDatabaseUtil.internal();

  FirebaseDatabaseUtil.internal();

  String _uniqueDeviceIdentifier = 'Unknown';

  factory FirebaseDatabaseUtil() {
    return _instance;
  }

  void initState() {
    // Demonstrates configuring to the database using a file
    _counterRef = FirebaseDatabase.instance.reference().child('counter');

    database.reference().child('counter').once().then((DataSnapshot snapshot) {
      print('Connected to second database and read ${snapshot.value}');
    });
    database.setPersistenceEnabled(true);
    _counterRef.keepSynced(true);

    _counterSubscription = _counterRef.onValue.listen((Event event) {
      error = null;
      _counter = event.snapshot.value ?? 0;
    }, onError: (Object o) {
      error = o;
    });
  }

  getData() async {
    return await FirebaseDatabase.instance
        .reference()
        .child('counter')
        .limitToFirst(1);
  }

  DatabaseError getError() {
    return error;
  }

  DatabaseReference ref() {
    return database.reference();
  }

  increment() async {
    final TransactionResult transactionResult =
        await _counterRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;

      return mutableData;
    });

    if (!transactionResult.committed) {
      print('Transaction not committed.');
      if (transactionResult.error != null) {
        print(transactionResult.error.message);
      }
    }
  }

  int getCounter() {
    return _counter;
  }

  void dispose() {
    _messagesSubscription.cancel();
    _counterSubscription.cancel();
  }
}
