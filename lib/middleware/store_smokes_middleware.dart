import 'package:cigarette_control/actions/actions.dart';
import 'package:cigarette_control/models/models.dart';
import 'package:cigarette_control/models/user.dart';
import 'package:cigarette_control/smokes_repository_core/smoke_repository_core.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createStoreSmokesMiddleware(
  ReactiveSmokesRepository smokesRepository,
  UserRepository userRepository,
) {
  return [
    TypedMiddleware<AppState, InitAppAction>(
      _firestoreSignIn(userRepository, smokesRepository),
    ),
    TypedMiddleware<AppState, ConnectToDataSourceAction>(
      _firestoreConnect(smokesRepository),
    ),
    TypedMiddleware<AppState, AddSmokeAction>(
      _firestoreSaveNewSmoke(smokesRepository),
    ),
    TypedMiddleware<AppState, DeleteSmokeAction>(
      _firestoreDeleteSmoke(smokesRepository),
    ),
      TypedMiddleware<AppState, LogoutAction>(
          _firestoreSignOut(userRepository, smokesRepository),
      ),
  ];
}

void Function(
  Store<AppState> store,
  InitAppAction action,
  NextDispatcher next,
    ) _firestoreSignIn(UserRepository repository,
    ReactiveSmokesRepository smokesRepository,
) {
  return (store, action, next) {
    next(action);

    repository.login().then((userEntity) {
      smokesRepository.setUserEntity(userEntity);
      store.dispatch(ConnectToDataSourceAction(User.fromEntity(userEntity)));
    });
  };
}

void Function(
    Store<AppState> store,
    LogoutAction action,
    NextDispatcher next,
    ) _firestoreSignOut(UserRepository repository,
    ReactiveSmokesRepository smokesRepository,) {
    return (store, action, next) {
        next(action);

        repository.logout().then((void _) {
            store.dispatch(InitAppAction());
    });
  };
}

void Function(
  Store<AppState> store,
  ConnectToDataSourceAction action,
  NextDispatcher next,
) _firestoreConnect(
  ReactiveSmokesRepository repository,
) {
  return (store, action, next) {
    next(action);

    repository.dailySmokes().listen((smokes) {
      store.dispatch(LoadDailySmokesAction(smokes.map(Smoke.fromEntity).toList()));
    });

    repository.monthlySmokes().listen((smokes) {
      store.dispatch(LoadMonthlySmokesAction(smokes.map(Smoke.fromEntity).toList()));
    });
  };
}

void Function(
  Store<AppState> store,
  AddSmokeAction action,
  NextDispatcher next,
) _firestoreSaveNewSmoke(
  ReactiveSmokesRepository repository,
) {
  return (store, action, next) {
    next(action);
    repository.addNewSmoke(action.smoke.toEntity());
  };
}

void Function(
  Store<AppState> store,
  DeleteSmokeAction action,
  NextDispatcher next,
) _firestoreDeleteSmoke(
  ReactiveSmokesRepository repository,
) {
  return (store, action, next) {
    next(action);
    repository.deleteSmoke([action.id]);
  };
}
