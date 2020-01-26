import 'package:cigarette_control/actions/actions.dart';
import 'package:cigarette_control/models/models.dart';
import 'package:cigarette_control/presentation/details_screen.dart';
import 'package:cigarette_control/selectors/selectors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class SmokeDetails extends StatelessWidget {
  final String id;

  SmokeDetails({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      ignoreChange: (state) => smokeSelector(state.monthlySmokes, id).isNotPresent,
      converter: (Store<AppState> store) {
        return _ViewModel.from(store, id);
      },
      builder: (context, vm) {
        return DetailsScreen(
          smoke: vm.smoke,
          onDelete: vm.onDelete,
        );
      },
    );
  }
}

class _ViewModel {
  final Smoke smoke;
  final Function onDelete;

  _ViewModel({@required this.smoke, @required this.onDelete});

  factory _ViewModel.from(Store<AppState> store, String id) {
    final smoke = smokeSelector(monthlySmokesSelector(store.state), id).value;

    return _ViewModel(smoke: smoke, onDelete: () => store.dispatch(DeleteSmokeAction(smoke.id)));
  }
}
