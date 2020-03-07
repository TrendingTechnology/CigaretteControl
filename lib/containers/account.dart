import 'package:cigarette_control/actions/actions.dart';
import 'package:cigarette_control/models/models.dart';
import 'package:cigarette_control/presentation/account_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class Account extends StatelessWidget {
  Account({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return AccountData(
          name: vm.name,
          email: vm.email,
          photoUrl: vm.photoUrl,
          onLogout: vm.onLogout,
        );
      },
    );
  }
}

class _ViewModel {
  final String email;
  final String name;
  final String photoUrl;
  final Function() onLogout;

  _ViewModel({@required this.email, @required this.name, @required this.photoUrl, @required this.onLogout});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        name: store.state.user.displayName,
        email: store.state.user.email,
        photoUrl: store.state.user.photoUrl,
        onLogout: () {
          store.dispatch(LogoutAction());
        });
  }
}
