// ignore_for_file: avoid_print
import 'dart:async' show FutureOr;
import 'log_storage.dart';

///
LogStorage buildLogStorage({String template}) => LogStorageStub(template: template);

///
class LogStorageStub implements LogStorage {
  ///
  @override
  final String template;

  ///
  const LogStorageStub({this.template});

  /// Init
  @override
  void init() => null;

  /// Dispose
  @override
  FutureOr<void> dispose() => null;

  /// Запись в хранилище
  FutureOr<void> store(LogMessage logMessage) {
    assert((){
      final String _message = _formatMessage(logMessage);
      if (_message is! String) return true;
      print(_message);
      return true;
    }());
    return null;
  }

  String _formatMessage(LogMessage logMessage) {
    final String _prefix = logMessage.prefix;
    final String _date = logMessage.date.toIso8601String();
    String _message = logMessage?.message?.toString();
    if (_message is! String) return null;
    return template?.replaceAll(r'$level', _prefix)
                            ?.replaceAll(r'$date', _date)
                            ?.replaceAll(r'$message', _message)
                            ?? '';
  }
}