import 'package:cigarette_control/actions/actions.dart';
import 'package:cigarette_control/firebase_flutter_repository/reactive_smokes_repository.dart';
import 'package:cigarette_control/firebase_flutter_repository/user_repository.dart';
import 'package:cigarette_control/localization.dart';
import 'package:cigarette_control/middleware/store_smokes_middleware.dart';
import 'package:cigarette_control/models/models.dart';
import 'package:cigarette_control/presentation/home_screen.dart';
import 'package:cigarette_control/reducers/app_state_reducer.dart';
import 'package:cigarette_control/smokes_app_core/smokes_app_core.dart';
import 'package:cigarette_control/smokes_repository_core/smoke_repository_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() {
    WidgetsFlutterBinding.ensureInitialized();

    runApp(CigaretteControlApp());
}

class CigaretteControlApp extends StatelessWidget {
    final Store<AppState> store;

    CigaretteControlApp({
        Key key,
        ReactiveSmokesRepository smokesRepository,
        UserRepository userRepository,
    })
        : store = Store<AppState>(
        appReducer,
        initialState: AppState.loading(),
        middleware: createStoreSmokesMiddleware(
            smokesRepository ??
                FirestoreReactiveSmokesRepository(Firestore.instance),
            userRepository ?? FirebaseUserRepository(FirebaseAuth.instance),
        ),
    ),
            super(key: key) {
        store.dispatch(InitAppAction());
    }

    @override
    Widget build(BuildContext context) {
        return StoreProvider(
            store: store,
            child: MaterialApp(
                onGenerateTitle: (context) =>
                FirestoreReduxLocalizations
                    .of(context)
                    .appTitle,
                theme: ArchSampleTheme.theme,
                localizationsDelegates: [
                    ArchSampleLocalizationsDelegate(),
                    FirestoreReduxLocalizationsDelegate(),
                ],
                routes: {
                    ArchRoutes.home: (context) => HomeScreen()
                },
            ),
        );
    }
}