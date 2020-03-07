import 'package:cigarette_control/actions/actions.dart';
import 'package:cigarette_control/models/models.dart';
import 'package:cigarette_control/models/user.dart';
import 'package:redux/redux.dart';

final dailySmokesReducer = combineReducers<List<Smoke>>([
  TypedReducer<List<Smoke>, LoadDailySmokesAction>(_setLoadedDailySmokes),
  TypedReducer<List<Smoke>, DeleteSmokeAction>(_deleteSmoke),
]);

final monthlySmokesReducer = combineReducers<List<Smoke>>([
  TypedReducer<List<Smoke>, LoadMonthlySmokesAction>(_setLoadedMonthlySmokes),
  TypedReducer<List<Smoke>, DeleteSmokeAction>(_deleteSmoke),
]);

final userReducer = combineReducers<User>([
    TypedReducer<User, ConnectToDataSourceAction>(_setUser),
]);

List<Smoke> _setLoadedDailySmokes(List<Smoke> smokes, LoadDailySmokesAction action) {
  return action.dailySmokes;
}

List<Smoke> _setLoadedMonthlySmokes(List<Smoke> smokes, LoadMonthlySmokesAction action) {
  return action.monthlySmokes;
}

User _setUser(User user, ConnectToDataSourceAction action) {
    return action.user;
}

List<Smoke> _deleteSmoke(List<Smoke> smokes, DeleteSmokeAction action) {
  return smokes..removeWhere((smoke) => smoke.id == action.id);
}
