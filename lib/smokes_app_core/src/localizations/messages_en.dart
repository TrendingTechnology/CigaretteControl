import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

// ignore: unused_element
final _keepAnalysisHappy = Intl.defaultLocale;

// ignore: non_constant_identifier_names
typedef MessageIfAbsent = void Function(String message_str, List args);

class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => 'en';

  static String m0(smoke) => 'Deleted "$smoke"';

  @override
  final messages = _notInlinedMessages(_notInlinedMessages);

  static Map<String, dynamic> _notInlinedMessages(_) => {
        'addSmoke': MessageLookupByLibrary.simpleMessage('Add Smoke'),
        'cancel': MessageLookupByLibrary.simpleMessage('Cancel'),
        'delete': MessageLookupByLibrary.simpleMessage('Delete'),
        'deleteSmoke': MessageLookupByLibrary.simpleMessage('Delete Smoke'),
        'deleteSmokeConfirmation': MessageLookupByLibrary.simpleMessage('Delete this smoke?'),
        'emptySmokeError': MessageLookupByLibrary.simpleMessage('Please enter some text'),
        'filterSmokes': MessageLookupByLibrary.simpleMessage('Filter Smokes'),
        'showDaily': MessageLookupByLibrary.simpleMessage('Show Daily'),
        'showAll': MessageLookupByLibrary.simpleMessage('Show All'),
        'showMonthly': MessageLookupByLibrary.simpleMessage('Show Monthly'),
        'stats': MessageLookupByLibrary.simpleMessage('Stats'),
        'smokeDeleted': m0,
        'smokeDetails': MessageLookupByLibrary.simpleMessage('Smoke Details'),
        'smokes': MessageLookupByLibrary.simpleMessage('Smokes'),
        'undo': MessageLookupByLibrary.simpleMessage('Undo')
      };
}
