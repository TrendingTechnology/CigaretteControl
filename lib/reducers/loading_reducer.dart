import 'package:cigarette_control/actions/actions.dart';
import 'package:redux/redux.dart';

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, LoadDailySmokesAction>(_setLoaded),
]);

bool _setLoaded(bool state, action) {
  return false;
}
