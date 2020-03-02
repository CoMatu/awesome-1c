import 'dart:async';

typedef LogWriter = FutureOr<String> Function(String message);

class Log {
  final StreamController<String> _controller = StreamController();

  void v(dynamic message) => _l('*', message.toString());
  void vv(dynamic message) => _l('**', message.toString());
  void vvv(dynamic message) => _l('***', message.toString());
  void vvvv(dynamic message) => _l('****', message.toString());
  void vvvvv(dynamic message) => _l('*****', message.toString());
  void vvvvvv(dynamic message) => _l('******', message.toString());
  // warning
  void w(dynamic message) => _l('W', message.toString());
  // error
  void e(dynamic message) => _l('E', message.toString());

  void _l(String prefix, String msg) {
    final DateTime _now = DateTime.now();
    this._controller.sink.add(' ${_now.toIso8601String()} || ${prefix.padLeft(6)} || $msg ');
  }

  Future<void> close() =>
    _controller.close();

  // Синхронный итератор задач
  Stream<String> iterateLog(StreamIterator<String> iterator, LogWriter writer) {
    StreamController<String> _resultSC = StreamController<String>();
    Future.doWhile(() => 
      iterator
        .moveNext()
        .then((bool hasNext) =>
          hasNext
          ? Future.value(writer(iterator.current)).then<void>(_resultSC.sink.add).then<bool>((_) => true)
          : _resultSC.close().then<bool>((void _) => false)
        )
    );
    return _resultSC.stream;
  }

  // SINGLETON +
  static final Log _singleton = Log._internal();
  factory Log() => _singleton;
  Log._internal() {
    // Итератор потока поступающих задач 
    final StreamIterator<String> _logIterator = StreamIterator<String>(_controller.stream);    
    // Запускаем итератор
    iterateLog(_logIterator, (String message) async {
      print(message);
      return message;
    });
  }
  // SINGLETON -
}