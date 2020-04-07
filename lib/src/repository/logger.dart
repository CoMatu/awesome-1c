// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes

import 'dart:async';
import 'log_storage/log_storage.dart';

typedef LogWriter = FutureOr<void> Function(LogMessage logMessage);

class Log {
  final StreamController<LogMessage> _controller = StreamController();
  final LogStorage _logStorage = LogStorage(template: r'[$level] $message');

  /// Verbose 1
  void v(dynamic message) =>      _l(message, LogLevel.v);

  /// Verbose 2
  void vv(dynamic message) =>     _l(message, LogLevel.vv);

  /// Verbose 3
  void vvv(dynamic message) =>    _l(message, LogLevel.vvv);

  /// Verbose 4
  void vvvv(dynamic message) =>   _l(message, LogLevel.vvvv);

  /// Verbose 5
  void vvvvv(dynamic message) =>  _l(message, LogLevel.vvvvv);

  /// Verbose 6
  void vvvvvv(dynamic message) => _l(message, LogLevel.vvvvvv);

  /// Info
  void i(dynamic message) =>      _l(message, LogLevel.info);

  /// Warning
  void w(dynamic message) =>      _l(message, LogLevel.warning);

  /// Error
  void e(dynamic message) =>      _l(message, LogLevel.error);

  /// Debug
  void d(dynamic message) =>      _l(message, LogLevel.debug);

  void _l(Object message, LogLevel prefix) {
    final DateTime _now = DateTime.now();
    _controller.sink.add(LogMessage(date: _now, message: message, level: prefix));
  }

  /// close
  Future<void> close() =>
    _controller.close()
    .whenComplete(_logStorage.dispose);

  // Семафор - итератор задач
  Stream<void> _iterateLog(StreamIterator<LogMessage> iterator, LogWriter writer) {
    SynchronousStreamController<void> _resultSC = StreamController<void>(sync: true) as SynchronousStreamController<void>;
    Future.doWhile(() => 
      iterator
        .moveNext()
        .then((bool hasNext) =>
          hasNext
          ? Future<void>.value(writer(iterator.current)).then<void>(_resultSC.sink.add).then<bool>((void _) => true)
          : _resultSC.close().then<bool>((void _) => false)
        )
    );
    return _resultSC.stream;
  }

  /// Запуск итератора
  void _startLogIterrator() {
    // Итератор потока поступающих задач 
    final StreamIterator<LogMessage> _logIterator = StreamIterator<LogMessage>(_controller.stream);    
    // Запускаем итератор
    _iterateLog(_logIterator, (LogMessage logMessage) async {
      return await _logStorage.store(logMessage);
    });
  }

  @override
  int get hashCode => 0;
  @override
  bool operator ==(Object obj) => obj is Log;
  @override
  String toString() => 'Instance of \'Log\'';

  // SINGLETON +
  static final Log _singleton = Log._internal();
  factory Log() => _singleton;
  Log._internal() {
    _logStorage.init();
    _startLogIterrator();
  }
  // SINGLETON -
}