import 'package:cigarette_control/actions/actions.dart';
import 'package:cigarette_control/models/models.dart';
import 'package:cigarette_control/presentation/smoke_list.dart';
import 'package:cigarette_control/selectors/selectors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class FilteredSmokes extends StatelessWidget {
  FilteredSmokes({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return SmokeList(
          smokes: vm.smokes,
          onRemove: vm.onRemove,
          onUndoRemove: vm.onUndoRemove,
        );
      },
    );
  }
}

class _ViewModel {
  final List<Smoke> smokes;
  final bool loading;
  final Function(Smoke) onRemove;
  final Function(Smoke) onUndoRemove;

  _ViewModel({
    @required this.smokes,
    @required this.loading,
    @required this.onRemove,
    @required this.onUndoRemove,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      smokes: filteredSmokesSelector(
        dailySmokesSelector(store.state),
        monthlySmokesSelector(store.state),
        activeFilterSelector(store.state),
      ),
      loading: store.state.isLoading,
      onRemove: (smoke) {
        store.dispatch(DeleteSmokeAction(smoke.id));
      },
      onUndoRemove: (smoke) {
        store.dispatch(AddSmokeAction(smoke));
      },
    );
  }
}
