import 'package:awesome1c/src/bloc/appBloc.dart';
export 'package:awesome1c/src/bloc/appBloc.dart';

class BlocHolder {
  final AppBloc appBloc = AppBloc();

  Future<void> close() =>
    Future.wait(<Future<void>>[
      appBloc.close(),
    ]);

  /* SINGLETON + */
  static final BlocHolder _internalSingletonBlocHolder = BlocHolder._singleton();
  factory BlocHolder() => _internalSingletonBlocHolder;
  BlocHolder._singleton();
  /* SINGLETON - */
}