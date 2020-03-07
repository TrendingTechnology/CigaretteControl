class UserEntity {
  final String id;
  final String displayName;
  final String photoUrl;
  final String email;

  UserEntity(this.id, this.displayName, this.photoUrl, this.email);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is UserEntity && runtimeType == other.runtimeType && id == other.id && displayName == other.displayName && photoUrl == other.photoUrl && email == other.email;

  @override
  int get hashCode => id.hashCode ^ displayName.hashCode ^ photoUrl.hashCode ^ email.hashCode;

  @override
  String toString() {
      return 'UserEntity{id: $id, displayName: $displayName, photoUrl: $photoUrl, email: $email}';
  }
}
