import 'dart:async';
import 'package:bloc/bloc.dart';

/* EVENTS */

/// Корневой класс событий приложения
abstract class AppEvent {}

/// Начать инициализацию приложения
class InitApp extends AppEvent {}


/* STATES */

/// Корневой класс состояний приложения
abstract class AppState {}

/// Класс отмечающий состояния как влияющие на автороутинг
abstract class AppRoutingState {}

/// Начальное состояние приложения
class InitialAppState extends AppState with AppRoutingState {}

/// Приложение инициализировано
class InitializedAppState extends AppState with AppRoutingState {}

/// Смена темы оформления приложения
class AppThemeChangedState extends AppState {}

/// BLoC приложения
class AppBloc extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => InitialAppState();

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is InitApp) {
      yield* initApp(event);
    } else {
      throw UnsupportedError('<Unknown event in AppBloc>');
    }
  }

  Stream<AppState> initApp(AppEvent event) async* {
    await Future<void>.delayed(const Duration(seconds: 3));
    yield InitializedAppState();
  }
}