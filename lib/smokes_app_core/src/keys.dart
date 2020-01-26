import 'package:flutter/widgets.dart';

class ArchSampleKeys {
  // Home Screens
  static const homeScreen = Key('__homeScreen__');
  static const addSmokeFab = Key('__addSmokeFab__');
  static const snackbar = Key('__snackbar__');

  static Key snackbarAction(String id) => Key('__snackbar_action_${id}__');

  // Smokes
  static const smokeList = Key('__smokeList__');
  static const smokesLoading = Key('__smokesLoading__');
  static final smokeItem = (String id) => Key('SmokeItem__${id}');
  static final smokeItemTask = (String id) => Key('SmokeItem__${id}__Task');
  static final smokeItemNote = (String id) => Key('SmokeItem__${id}__Note');

  // Tabs
  static const tabs = Key('__tabs__');
  static const smokeTab = Key('__smokeTab__');
  static const statsTab = Key('__statsTab__');

  // Filters
  static const filterButton = Key('__filterButton__');
  static const allFilter = Key('__allFilter__');
  static const dailyFilter = Key('__dailyFilter__');
  static const monthlyFilter = Key('__monthlyFilter__');

  // Stats
  static const statsCounter = Key('__statsCounter__');
  static const statsLoading = Key('__statsLoading__');
  static const statsNumDaily = Key('__statsDailyItems__');
  static const statsNumMonthly = Key('__statsMonthlyItems__');

  // Details Screen
  static const deleteSmokeButton = Key('__deleteSmokeFab__');
  static const smokeDetailsScreen = Key('__smokeDetailsScreen__');
  static final detailsSmokeItemTask = Key('DetailsSmoke__Task');
  static final detailsSmokeItemNote = Key('DetailsSmoke__Note');
}
