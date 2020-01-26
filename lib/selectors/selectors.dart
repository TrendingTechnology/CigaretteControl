import 'package:cigarette_control/models/models.dart';
import 'package:cigarette_control/smokes_app_core/smokes_app_core.dart';

List<Smoke> dailySmokesSelector(AppState state) => state.dailySmokes;

List<Smoke> monthlySmokesSelector(AppState state) => state.monthlySmokes;

VisibilityFilter activeFilterSelector(AppState state) => state.activeFilter;

AppTab activeTabSelector(AppState state) => state.activeTab;

bool isLoadingSelector(AppState state) => state.isLoading;

List<Smoke> filteredSmokesSelector(
  List<Smoke> dailySmokes,
  List<Smoke> monthlySmokes,
  VisibilityFilter activeFilter,
) {
  switch (activeFilter) {
    case VisibilityFilter.daily:
      return dailySmokes;
    case VisibilityFilter.monthly:
      return monthlySmokes;
    case VisibilityFilter.all:
    default:
      return monthlySmokes;
  }
}

Optional<Smoke> smokeSelector(List<Smoke> smokes, String id) {
  try {
    return Optional.of(smokes.firstWhere((smoke) => smoke.id == id));
  } catch (e) {
    return Optional.absent();
  }
}
