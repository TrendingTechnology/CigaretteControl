import 'package:cigarette_control/models/models.dart';
import 'package:cigarette_control/models/user.dart';
import 'package:cigarette_control/models/visibility_filter.dart';

class LoadDailySmokesAction {
  final List<Smoke> dailySmokes;

  LoadDailySmokesAction(this.dailySmokes);

  @override
  String toString() {
    return 'LoadSmokesAction{smokes: $dailySmokes}';
  }
}

class LoadMonthlySmokesAction {
  final List<Smoke> monthlySmokes;

  LoadMonthlySmokesAction(this.monthlySmokes);

  @override
  String toString() {
    return 'LoadMonthlySmokesAction{smokes: $monthlySmokes}';
  }
}

class DeleteSmokeAction {
  final String id;

  DeleteSmokeAction(this.id);

  @override
  String toString() {
    return 'DeleteSmokeAction{id: $id}';
  }
}

class AddSmokeAction {
  final Smoke smoke;

  AddSmokeAction(this.smoke);

  @override
  String toString() {
    return 'AddSmokeAction{smoke: $smoke}';
  }
}

class InitAppAction {
  @override
  String toString() {
    return 'InitAppAction{}';
  }
}

class ConnectToDataSourceAction {
    final User user;

    ConnectToDataSourceAction(this.user);

    @override
    String toString() {
        return 'ConnectToDataSourceAction{}';
    }
}

class UpdateFilterAction {
  final VisibilityFilter newFilter;

  UpdateFilterAction(this.newFilter);

  @override
  String toString() {
    return 'UpdateFilterAction{newFilter: $newFilter}';
  }
}

class UpdateTabAction {
  final AppTab newTab;

  UpdateTabAction(this.newTab);

  @override
  String toString() {
    return 'UpdateTabAction{newTab: $newTab}';
  }
}

class LogoutAction {
    @override
    String toString() {
        return 'LogoutAction{}';
    }
}
