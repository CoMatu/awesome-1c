import 'package:awesome1c/src/repository/logger.dart';
import 'package:test/test.dart';

void main() {
  test('Loopback', () {
    expect(true, true);
  });

  test('Logger', () {
    final Log log = Log();
    log.i('If u can see this ... ');
    log.v('... and this ...');
    log.d('... Logger test passed.');
  });
}