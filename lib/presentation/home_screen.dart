import 'package:cigarette_control/actions/actions.dart';
import 'package:cigarette_control/containers/active_tab.dart';
import 'package:cigarette_control/containers/filter_selector.dart';
import 'package:cigarette_control/containers/filtered_smokes.dart';
import 'package:cigarette_control/containers/stats.dart';
import 'package:cigarette_control/containers/tab_selector.dart';
import 'package:cigarette_control/localization.dart';
import 'package:cigarette_control/models/models.dart';
import 'package:cigarette_control/smokes_app_core/smokes_app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

typedef OnSaveCallback = void Function();

class HomeScreen extends StatelessWidget {
  HomeScreen() : super(key: ArchSampleKeys.homeScreen);

  @override
  Widget build(BuildContext context) {
    return ActiveTab(
      builder: (BuildContext context, AppTab activeTab) {
        return Scaffold(
          appBar: AppBar(
            title: Text(FirestoreReduxLocalizations.of(context).appTitle),
            actions: [
              FilterSelector(visible: activeTab == AppTab.smokes),
            ],
          ),
          body: activeTab == AppTab.smokes ? FilteredSmokes() : Stats(),
          floatingActionButton: FloatingActionButton(
            key: ArchSampleKeys.addSmokeFab,
            onPressed: () {
              StoreProvider.of<AppState>(context, listen: false).dispatch(AddSmokeAction(Smoke(
                date: new DateTime.now(),
              )));
            },
            child: Icon(Icons.add),
            tooltip: ArchSampleLocalizations.of(context).addSmoke,
          ),
          bottomNavigationBar: TabSelector(),
        );
      },
    );
  }
}
