import 'package:cigarette_control/containers/account.dart';
import 'package:cigarette_control/containers/filtered_smokes.dart';
import 'package:cigarette_control/containers/stats.dart';
import 'package:cigarette_control/smokes_app_core/src/keys.dart';
import 'package:cigarette_control/smokes_app_core/src/localization.dart';
import 'package:flutter/material.dart';

enum AppTab { smokes, stats, account }

extension AppTabWithIcon on AppTab {
  IconData get icon {
    switch (this) {
      case AppTab.smokes:
        return Icons.list;
      case AppTab.stats:
        return Icons.show_chart;
      case AppTab.account:
        return Icons.account_circle;
      default:
        return null;
    }
  }

  Key get key {
    switch (this) {
      case AppTab.smokes:
        return ArchSampleKeys.smokeTab;
      case AppTab.stats:
        return ArchSampleKeys.statsTab;
      case AppTab.account:
        return ArchSampleKeys.accountTab;
      default:
        return null;
    }
  }

  String makeTitle(BuildContext context) {
    switch (this) {
      case AppTab.smokes:
        return ArchSampleLocalizations.of(context).smokes;
      case AppTab.stats:
        return ArchSampleLocalizations.of(context).stats;
      case AppTab.account:
        return ArchSampleLocalizations.of(context).account;
      default:
        return null;
    }
  }

  Widget get contentWidget {
    switch (this) {
      case AppTab.smokes:
        return FilteredSmokes();
      case AppTab.stats:
        return Stats();
      case AppTab.account:
        return Account();
      default:
        return null;
    }
  }
}
