import 'dart:async';

import 'package:cigarette_control/smokes_repository_core/smoke_repository_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class FirestoreReactiveSmokesRepository implements ReactiveSmokesRepository {
  static const String path = 'smoke';

  final Firestore firestore;

  const FirestoreReactiveSmokesRepository(this.firestore);

  @override
  Future<void> addNewSmoke(SmokeEntity smoke) {
    return firestore.collection(path).document(smoke.id).setData(smoke.toJson());
  }

  @override
  Future<void> deleteSmoke(List<String> idList) async {
    await Future.wait<void>(idList.map((id) {
      return firestore.collection(path).document(id).delete();
    }));
  }

  @override
  Stream<List<SmokeEntity>> dailySmokes() {
    return firestore.collection(path).where("date", isGreaterThanOrEqualTo: DateTime.parse(new DateFormat('yyyyMMdd').format(new DateTime.now()))).snapshots().map((snapshot) {
      return snapshot.documents.map((doc) {
        return SmokeEntity(
          doc.documentID,
          (doc['date'] as Timestamp).toDate(),
        );
      }).toList();
    });
  }

  @override
  Stream<List<SmokeEntity>> monthlySmokes() {
    return firestore.collection(path).where("date", isGreaterThanOrEqualTo: DateTime.parse(new DateFormat('yyyyMM01').format(new DateTime.now()))).snapshots().map((snapshot) {
      return snapshot.documents.map((doc) {
        return SmokeEntity(
          doc.documentID,
          (doc['date'] as Timestamp).toDate(),
        );
      }).toList();
    });
  }
}
