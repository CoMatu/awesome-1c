import 'dart:async' show FutureOr;
import 'stub_log_storage.dart'
  // ignore: uri_does_not_exist
  if (dart.library.html) 'web_log_storage.dart'
  // ignore: uri_does_not_exist
  if (dart.library.io) 'io_log_storage.dart';

///
abstract class LogStorage {
  ///
  final String template;

  ///
  factory LogStorage({String template = r'[$level] $message'}) =>
    buildLogStorage(template: template);

  /// Init
  void init();

  /// Dispose
  FutureOr<void> dispose();

  /// Запись в хранилище
  FutureOr<void> store(LogMessage logMessage);

}

///
class LogMessage {
  final DateTime date;
  final dynamic message;
  final LogLevel level;
  String get prefix => _prefixFromLogLevel();
  const LogMessage({this.date, this.message, LogLevel level})
    : assert(date is DateTime && message != null)
    , level = level ?? LogLevel.vvvvvv;
  
  String _prefixFromLogLevel() {
    switch (level) {
      case (LogLevel.v):        return '     *';
      case (LogLevel.vv):       return '    **';
      case (LogLevel.vvv):      return '   ***';
      case (LogLevel.vvvv):     return '  ****';
      case (LogLevel.vvvvv):    return ' *****';
      case (LogLevel.vvvvvv):   return '******';
      case (LogLevel.info):     return '     i';
      case (LogLevel.warning):  return '     w';
      case (LogLevel.error):    return '     e';
      case (LogLevel.debug):    return '     d';
      default:                  return '      ';
    }
  }
}

enum LogLevel {
  v,
  vv,
  vvv,
  vvvv,
  vvvvv,
  vvvvvv,
  info,
  warning,
  error,
  debug,
}