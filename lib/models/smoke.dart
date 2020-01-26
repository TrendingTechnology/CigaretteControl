import 'package:cigarette_control/smokes_app_core/smokes_app_core.dart';
import 'package:cigarette_control/smokes_repository_core/smoke_repository_core.dart';
import 'package:meta/meta.dart';

@immutable
class Smoke {
  final String id;
  final DateTime date;

  Smoke({DateTime date, String id})
      : date = date ?? '',
        id = id ?? Uuid().generateV4();

  Smoke copyWith({String id, DateTime date}) {
    return Smoke(
      id: id ?? this.id,
      date: date ?? this.date,
    );
  }

  @override
  int get hashCode => date.hashCode ^ id.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Smoke && runtimeType == other.runtimeType && date == other.date && id == other.id;

  @override
  String toString() {
    return 'Smoke{date: $date, id: $id}';
  }

  SmokeEntity toEntity() {
    return SmokeEntity(id, date);
  }

  static Smoke fromEntity(SmokeEntity entity) {
    return Smoke(
      date: entity.date,
      id: entity.id ?? Uuid().generateV4(),
    );
  }
}
