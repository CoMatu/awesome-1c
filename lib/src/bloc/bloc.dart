import '../models/user.dart';
import 'app/bloc.dart';

export 'app/bloc.dart';

class BlocHolder {
  final AppBloc appBloc = AppBloc();
  User get currentUser => appBloc.currentUser;

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

