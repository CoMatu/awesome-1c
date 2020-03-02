import 'package:awesome1c/src/repository/logger.dart';
import 'package:bloc/bloc.dart';

class PlagueBlocDelegate extends BlocDelegate {
  final Log _log = Log();

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    //this._log.vvvvvv('Event \'${event.toString()}\' in BLoC \'${bloc.toString()}\'');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    //this._log.vvvvvv('Transition \'${transition.currentState.toString()} -> ${transition.nextState.toString()}\' with event \'${transition.event.toString()}\' in BLoC \'${bloc.toString()}\'');
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    this._log.e('Error \'${error.toString()}\' in BLoC \'${bloc.toString()}\'');
  }
}