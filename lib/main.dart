import 'entry_points/main_stub.dart'
  // ignore: uri_does_not_exist
  if (dart.library.html) 'entry_points/main_web.dart'
  // ignore: uri_does_not_exist
  if (dart.library.io) 'entry_points/main_io.dart';

/// Universal router for platform specific entry point
void main() => 
  runner();