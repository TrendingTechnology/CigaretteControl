import 'package:cigarette_control/actions/actions.dart';
import 'package:cigarette_control/models/models.dart';
import 'package:cigarette_control/smokes_app_core/smokes_app_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class TabSelector extends StatelessWidget {
  TabSelector({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return BottomNavigationBar(
          key: ArchSampleKeys.tabs,
          currentIndex: AppTab.values.indexOf(vm.activeTab),
          onTap: vm.onTabSelected,
          items: AppTab.values.map((tab) {
            return BottomNavigationBarItem(
              icon: Icon(
                tab.icon,
                key: tab.key,
              ),
              title: Text(tab.makeTitle(context)),
            );
          }).toList(),
        );
      },
    );
  }
}

class _ViewModel {
  final AppTab activeTab;
  final Function(int) onTabSelected;

  _ViewModel({
    @required this.activeTab,
    @required this.onTabSelected,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      activeTab: store.state.activeTab,
      onTabSelected: (index) {
        store.dispatch(UpdateTabAction((AppTab.values[index])));
      },
    );
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is _ViewModel && runtimeType == other.runtimeType && activeTab == other.activeTab;

  @override
  int get hashCode => activeTab.hashCode;
}
