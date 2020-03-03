import 'dart:async' show FutureOr;
import 'dart:html' as html show window, Console;
import 'package:awesome1c/src/repository/log_storage/log_storage.dart';

///
LogStorage buildLogStorage({String template}) => LogStorageHTML(template: template);

///
class LogStorageHTML implements LogStorage {
  ///
  @override
  final String template;

  html.Console _console;

  ///
  LogStorageHTML({String template})
    : template = template;

  @override
  void init() {
    _console = html.window.console;    
  }

  @override
  FutureOr<void> dispose() {
    _console = null;
  }

  /// Запись в хранилище
  FutureOr<void> store(LogMessage logMessage) {
    assert((){
      final String _message = _formatMessage(logMessage);
      if (_message is! String) return true;
      switch (logMessage.level) {
        case (LogLevel.v):        _console.log(_message); break;
        case (LogLevel.vv):       _console.log(_message); break;
        case (LogLevel.vvv):      _console.log(_message); break;
        case (LogLevel.vvvv):     _console.log(_message); break;
        case (LogLevel.vvvvv):    _console.log(_message); break;
        case (LogLevel.vvvvvv):   _console.log(_message); break;
        case (LogLevel.info):     _console.info(_message); break;
        case (LogLevel.warning):  _console.warn(_message); break;
        case (LogLevel.error):    _console.error(_message); break;
        case (LogLevel.debug):    _console.debug(_message); break;
        default:                  _console.log(_message); break;
      }
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