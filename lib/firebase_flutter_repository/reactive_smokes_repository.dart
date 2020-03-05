import 'dart:async';

import 'package:cigarette_control/smokes_repository_core/smoke_repository_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class FirestoreReactiveSmokesRepository implements ReactiveSmokesRepository {
  static const String users_path = 'users';
  static const String smokes_path = 'smokes';

  final Firestore firestore;

  UserEntity userEntity;

  FirestoreReactiveSmokesRepository(this.firestore);

  @override
  Future<void> addNewSmoke(SmokeEntity smoke) {
    return getCurrentUserSmokesCollection().document(smoke.id).setData(smoke.toJson());
  }

  @override
  Future<void> deleteSmoke(List<String> idList) async {
    await Future.wait<void>(idList.map((id) {
      return getCurrentUserSmokesCollection().document(id).delete();
    }));
  }

  @override
  Stream<List<SmokeEntity>> dailySmokes() {
    return getCurrentUserSmokesCollection()
        .where("date", isGreaterThanOrEqualTo: DateTime.parse(new DateFormat('yyyyMMdd').format(new DateTime.now())))
        .orderBy("date", descending: true)
        .snapshots()
        .map((snapshot) {
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
    return getCurrentUserSmokesCollection()
        .where("date", isGreaterThanOrEqualTo: DateTime.parse(new DateFormat('yyyyMM01').format(new DateTime.now())))
        .orderBy("date", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.documents.map((doc) {
        return SmokeEntity(
          doc.documentID,
          (doc['date'] as Timestamp).toDate(),
        );
      }).toList();
    });
  }

  @override
  void setUserEntity(UserEntity userEntity) {
    this.userEntity = userEntity;
  }

  CollectionReference getCurrentUserSmokesCollection() {
    return firestore.collection(users_path).document(userEntity.id).collection(smokes_path);
  }
}
