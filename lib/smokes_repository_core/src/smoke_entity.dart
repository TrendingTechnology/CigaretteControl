class SmokeEntity {
  final String id;
  final DateTime date;

  SmokeEntity(this.id, this.date);

  @override
  int get hashCode => date.hashCode ^ id.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SmokeEntity && runtimeType == other.runtimeType && date == other.date && id == other.id;

  Map<String, Object> toJson() {
    return {
      'date': date,
      'id': id,
    };
  }

  @override
  String toString() {
    return 'SmokeEntity{date: $date, id: $id}';
  }

  static SmokeEntity fromJson(Map<String, Object> json) {
    return SmokeEntity(
      json['id'] as String,
      json['date'] as DateTime,
    );
  }
}
