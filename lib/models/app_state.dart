import 'package:cigarette_control/models/models.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final bool isLoading;
  final List<Smoke> dailySmokes;
  final List<Smoke> monthlySmokes;
  final AppTab activeTab;
  final VisibilityFilter activeFilter;

  AppState({
    this.isLoading = false,
    this.dailySmokes = const [],
    this.monthlySmokes = const [],
    this.activeTab = AppTab.smokes,
    this.activeFilter = VisibilityFilter.all,
  });

  factory AppState.loading() => AppState(isLoading: true);

  @override
  int get hashCode => isLoading.hashCode ^ dailySmokes.hashCode ^ monthlySmokes.hashCode ^ activeTab.hashCode ^ activeFilter.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          dailySmokes == other.dailySmokes &&
          monthlySmokes == other.monthlySmokes &&
          activeTab == other.activeTab &&
          activeFilter == other.activeFilter;

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, daily smokes: $dailySmokes, monthly smokes: $dailySmokes, activeTab: $activeTab, activeFilter: $activeFilter}';
  }
}
