import 'dart:async';

import 'package:flutter/material.dart';

class FirestoreReduxLocalizations {
  static FirestoreReduxLocalizations of(BuildContext context) {
    return Localizations.of<FirestoreReduxLocalizations>(
      context,
      FirestoreReduxLocalizations,
    );
  }

  String get appTitle => 'Cigarette Control';
}

class FirestoreReduxLocalizationsDelegate extends LocalizationsDelegate<FirestoreReduxLocalizations> {
  @override
  Future<FirestoreReduxLocalizations> load(Locale locale) => Future(() => FirestoreReduxLocalizations());

  @override
  bool shouldReload(FirestoreReduxLocalizationsDelegate old) => false;

  @override
  bool isSupported(Locale locale) => locale.languageCode.toLowerCase().contains('en');
}
