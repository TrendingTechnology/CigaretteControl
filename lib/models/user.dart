import 'package:cigarette_control/smokes_app_core/smokes_app_core.dart';
import 'package:cigarette_control/smokes_repository_core/smoke_repository_core.dart';
import 'package:meta/meta.dart';

@immutable
class User {
  final String id;
  final String displayName;
  final String photoUrl;
  final String email;

  User({String id, String displayName, String photoUrl, String email})
      : id = id ?? Uuid().generateV4(),
        displayName = displayName ?? '',
        photoUrl = photoUrl ?? '',
        email = email ?? '';

  @override
  int get hashCode => id.hashCode ^ displayName.hashCode ^ photoUrl.hashCode ^ email.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is User && runtimeType == other.runtimeType && id == other.id && displayName == other.displayName && photoUrl == other.photoUrl && email == other.email;

  @override
  String toString() {
    return 'User{id: $id, name: $displayName, photoUrl: $photoUrl, email: $email}';
  }

  UserEntity toEntity() {
    return UserEntity(id, displayName, photoUrl, email);
  }

  static User fromEntity(UserEntity entity) {
    return User(
      id: entity.id,
      displayName: entity.displayName,
      photoUrl: entity.photoUrl,
      email: entity.email,
    );
  }
}
