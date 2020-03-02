import 'dart:async';
import 'package:pedantic/pedantic.dart' show unawaited;
import 'package:awesome1c/src/models/item.dart';
import 'package:awesome1c/src/models/user.dart';
import 'package:awesome1c/src/repository/firebase_provider.dart';
import 'package:awesome1c/src/repository/hive_provider.dart';
import 'package:awesome1c/src/repository/logger.dart';
import 'package:bloc/bloc.dart';
import 'package:awesome1c/src/bloc/app/events.dart';
import 'package:awesome1c/src/bloc/app/states.dart';
import 'package:rxdart/rxdart.dart';
export 'package:awesome1c/src/bloc/app/events.dart';
export 'package:awesome1c/src/bloc/app/states.dart';


/// BLoC приложения
class AppBloc extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => InitialAppState();

  User _currentUser = User.empty();
  User get currentUser => _currentUser ?? User.empty();

  final Log _log = Log();
  final FirebaseProvider _firebaseProvider = FirebaseProvider();
  final HiveProvider _hiveProvider = HiveProvider();

  Stream<T> whereState<T>() =>
    whereType<T>();

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is InitApp) {
      yield* _initApp(event);
    } else if (event is ChangeAppTheme){
      yield* _changeAppTheme(event);
    } else if (event is SetAuthState) {
      yield* _setAuthState(event);
    } else if (event is SignIn) {
      unawaited(_firebaseProvider.signIn());
    } else if (event is SignOut) {
      unawaited(_firebaseProvider.signOut());
    } else if (event is HandleItemSelection) {
      yield _handleItemSelection(event);
    } else {
      throw UnsupportedError('<Unknown event in AppBloc>');
    }
  }

  //
  Stream<AppState> _initApp(InitApp event) async* {
    _log.vv('Начинаем инициализацию приложения');

    // Firebase
    _log.vvv('Инициализируем Firebase');
    await _firebaseProvider.init();
    _log.vvvv('Firebase инициализирован');

    // Hive
    _log.vvv('Инициализируем Hive');
    await _hiveProvider.init();
    _log.vvvv('Hive инициализирован');

    // Current user
    _log.vvv('Установим поток состояний авторизации');
    unawaited(
      _firebaseProvider.onAuthStateChanged.forEach((User user) => add(SetAuthState(user)))
    );

    yield InitializedAppState();
    _log.vvv('Приложение успешно инициализировано');
  }

  @override
  Future<void> close() =>
    super.close();

  //
  Stream<AppState> _changeAppTheme(ChangeAppTheme event) async* {
    /// TODO: смена цвета статус бара
    /// менять цвет фона HTML на цвет AppBar'а
    /// менять мета тэг <meta name="theme-color" content="#c2185b">

    yield AppThemeChangedState(event.appTheme);
  }

  //
  AppState _handleItemSelection(HandleItemSelection event) {
    final Item item = event.item;
    if (item?.isNotEmpty ?? false) {
      if (event.item.user == currentUser) {
        _log.vvv('Обновить существующий элемент');
        return UpdateItem(item);
      } else {
        _log.vvv('Просмотреть существующий элемент');
        return ReadItem(item);
      }
    }
    if (currentUser is! User || currentUser.isEmpty) {
      _log.vvv('Нельзя создать новый элемент так как не авторизован. Будет показан экран авторизации');
      return const NotAuthorized(showAuthScreen: true);
    }
    _log.vvv('Начать создание нового элемента');
    return CreateItem(Item.fromUser(currentUser));
  }

  //
  Stream<AppState> _setAuthState(SetAuthState event) async* {
    if (event.authorized) {
      _currentUser = event.user;
      yield Authorized(currentUser);
      _log.vvv('Авторизован как ${currentUser.toString()}');
    } else {
      _currentUser = User.empty();
      yield const NotAuthorized();
      _log.vvv('Не авторизован');
    }
  }
}