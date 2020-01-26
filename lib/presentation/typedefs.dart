import 'package:cigarette_control/models/models.dart';

typedef SmokeAdder = void Function(Smoke smoke);

typedef SmokeRemover = void Function(String id);

typedef SmokeUpdater = void Function(String id, Smoke smoke);
