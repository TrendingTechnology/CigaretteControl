import 'package:cigarette_control/models/models.dart';
import 'package:cigarette_control/presentation/stats_counter.dart';
import 'package:cigarette_control/selectors/selectors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class Stats extends StatelessWidget {
  Stats({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return StatsCounter(
          numDaily: vm.numDaily,
          numMonthly: vm.numMonthly,
        );
      },
    );
  }
}

class _ViewModel {
  final int numMonthly;
  final int numDaily;

  _ViewModel({@required this.numMonthly, @required this.numDaily});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      numDaily: dailySmokesSelector(store.state).length,
      numMonthly: monthlySmokesSelector(store.state).length,
    );
  }
}
