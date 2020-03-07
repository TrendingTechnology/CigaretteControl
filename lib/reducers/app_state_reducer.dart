import 'package:cigarette_control/models/models.dart';
import 'package:cigarette_control/reducers/loading_reducer.dart';
import 'package:cigarette_control/reducers/smokes_reducer.dart';
import 'package:cigarette_control/reducers/tabs_reducer.dart';
import 'package:cigarette_control/reducers/visibility_reducer.dart';

// We create the State reducer by combining many smaller reducers into one!
AppState appReducer(AppState state, action) {
  return AppState(
    isLoading: loadingReducer(state.isLoading, action),
    dailySmokes: dailySmokesReducer(state.dailySmokes, action),
    monthlySmokes: monthlySmokesReducer(state.monthlySmokes, action),
      user: userReducer(state.user, action),
    activeFilter: visibilityReducer(state.activeFilter, action),
    activeTab: tabsReducer(state.activeTab, action),
  );
}
