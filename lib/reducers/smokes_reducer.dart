import 'package:cigarette_control/actions/actions.dart';
import 'package:cigarette_control/models/models.dart';
import 'package:redux/redux.dart';

final dailySmokesReducer = combineReducers<List<Smoke>>([
  TypedReducer<List<Smoke>, LoadDailySmokesAction>(_setLoadedDailySmokes),
  TypedReducer<List<Smoke>, DeleteSmokeAction>(_deleteSmoke),
]);

final monthlySmokesReducer = combineReducers<List<Smoke>>([
  TypedReducer<List<Smoke>, LoadMonthlySmokesAction>(_setLoadedMonthlySmokes),
  TypedReducer<List<Smoke>, DeleteSmokeAction>(_deleteSmoke),
]);

List<Smoke> _setLoadedDailySmokes(List<Smoke> smokes, LoadDailySmokesAction action) {
  return action.dailySmokes;
}

List<Smoke> _setLoadedMonthlySmokes(List<Smoke> smokes, LoadMonthlySmokesAction action) {
  return action.monthlySmokes;
}

List<Smoke> _deleteSmoke(List<Smoke> smokes, DeleteSmokeAction action) {
  return smokes..removeWhere((smoke) => smoke.id == action.id);
}
