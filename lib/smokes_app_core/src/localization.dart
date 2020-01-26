import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'localizations/messages_all.dart';

class ArchSampleLocalizations {
  ArchSampleLocalizations(this.locale);

  final Locale locale;

  static Future<ArchSampleLocalizations> load(Locale locale) {
    return initializeMessages(locale.toString()).then((_) {
      return ArchSampleLocalizations(locale);
    });
  }

  static ArchSampleLocalizations of(BuildContext context) {
    return Localizations.of<ArchSampleLocalizations>(context, ArchSampleLocalizations);
  }

  String get smokes => Intl.message(
        'Smokes',
        name: 'smokes',
        args: [],
        locale: locale.toString(),
      );

  String get stats => Intl.message(
        'Stats',
        name: 'stats',
        args: [],
        locale: locale.toString(),
      );

  String get showAll => Intl.message(
        'Show All',
        name: 'showAll',
        args: [],
        locale: locale.toString(),
      );

  String get showDaily => Intl.message(
        'Show Daily',
        name: 'showDaily',
        args: [],
        locale: locale.toString(),
      );

  String get showMonthly => Intl.message(
        'Show Monthly',
        name: 'showMonthly',
        args: [],
        locale: locale.toString(),
      );

  String get addSmoke => Intl.message(
        'Add Smoke',
        name: 'addSmoke',
        args: [],
        locale: locale.toString(),
      );

  String get saveChanges => Intl.message(
        'Save changes',
        name: 'saveChanges',
        args: [],
        locale: locale.toString(),
      );

  String get filterSmokes => Intl.message(
        'Filter Smokes',
        name: 'filterSmokes',
        args: [],
        locale: locale.toString(),
      );

  String get deleteSmoke => Intl.message(
        'Delete Smoke',
        name: 'deleteSmoke',
        args: [],
        locale: locale.toString(),
      );

  String get smokeDetails => Intl.message(
        'Smoke Details',
        name: 'smokeDetails',
        args: [],
        locale: locale.toString(),
      );

  String get emptySmokeError => Intl.message(
        'Please enter some text',
        name: 'emptySmokeError',
        args: [],
        locale: locale.toString(),
      );

  String get monthly => Intl.message(
        'Monthly',
        name: 'monthlySmokes',
        args: [],
        locale: locale.toString(),
      );

  String get daily => Intl.message(
        'Daily',
        name: 'daily',
        args: [],
        locale: locale.toString(),
      );

  String smokeDeleted(String task) => Intl.message(
        'Deleted "$task"',
        name: 'smokeDeleted',
        args: [task],
        locale: locale.toString(),
      );

  String get undo => Intl.message(
        'Undo',
        name: 'undo',
        args: [],
        locale: locale.toString(),
      );

  String get deleteSmokeConfirmation => Intl.message(
        'Delete this smoke?',
        name: 'deleteSmokeConfirmation',
        args: [],
        locale: locale.toString(),
      );

  String get delete => Intl.message(
        'Delete',
        name: 'delete',
        args: [],
        locale: locale.toString(),
      );

  String get cancel => Intl.message(
        'Cancel',
        name: 'cancel',
        args: [],
        locale: locale.toString(),
      );
}

class ArchSampleLocalizationsDelegate extends LocalizationsDelegate<ArchSampleLocalizations> {
  @override
  Future<ArchSampleLocalizations> load(Locale locale) => ArchSampleLocalizations.load(locale);

  @override
  bool shouldReload(ArchSampleLocalizationsDelegate old) => false;

  @override
  bool isSupported(Locale locale) => locale.languageCode.toLowerCase().contains('en');
}
