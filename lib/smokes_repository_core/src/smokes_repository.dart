import 'dart:async';
import 'dart:core';

import 'smoke_entity.dart';

/// A class that Loads and Persists smokes. The data layer of the app.
///
/// How and where it stores the entities should defined in a concrete
/// implementation, such as smokes_repository_simple or smokes_repository_web.
///
/// The domain layer should depend on this abstract class, and each app can
/// inject the correct implementation depending on the environment, such as
/// web or Flutter.
abstract class SmokesRepository {
  /// Loads smokes first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Smokes from a Web Client.
  Future<List<SmokeEntity>> loadSmokes();

  // Persists smokes to local disk and the web
  Future saveSmokes(List<SmokeEntity> smokes);
}
