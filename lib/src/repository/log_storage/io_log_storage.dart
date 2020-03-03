// ignore_for_file: avoid_print
import 'dart:async' show FutureOr;
import 'dart:io' as io;
import 'package:awesome1c/src/repository/log_storage/log_storage.dart';

///
LogStorage buildLogStorage({String template}) => LogStorageIO(template: template);

///
class LogStorageIO implements LogStorage {
  ///
  @override
  final String template;

  io.Stdout _console;

  ///
  LogStorageIO({String template})
    : template = template;

  /// Init
  @override
  void init() {
    _console = io.stdout;   
  }

  /// Dispose
  @override
  FutureOr<void> dispose() async {
    await _console.flush();
    await _console.close();
    _console = null;
  }

  /// Запись в хранилище
  FutureOr<void> store(LogMessage logMessage) {
    assert((){
      final String _message = _formatMessage(logMessage);
      if (_message is! String) return true;
      _console.writeln(_message);
      //print(_message);
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

