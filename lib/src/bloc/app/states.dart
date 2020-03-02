import 'package:awesome1c/src/models/app_theme.dart';
import 'package:awesome1c/src/models/item.dart';
import 'package:awesome1c/src/models/user.dart';

/* STATES */

/// Корневой класс состояний приложения
abstract class AppState {
  const AppState();
}

/// Класс отмечающий состояния как влияющие на автороутинг
abstract class AppRoutingState {}

/// Начальное состояние приложения
class InitialAppState extends AppState with AppRoutingState {}

/// Приложение инициализировано
class InitializedAppState extends AppState with AppRoutingState {}


/// Смена темы оформления приложения
class AppThemeChangedState extends AppState {
  final AppTheme appTheme;
  const AppThemeChangedState(this.appTheme);
}


///
abstract class AuthorizedState {}

///
class Authorized extends AppState with AuthorizedState, AppRoutingState {
  final User user;
  const Authorized(this.user)
    : assert(user is User);
}

///
class NotAuthorized extends AppState with AuthorizedState, AppRoutingState {
  final bool showAuthScreen;
  const NotAuthorized({bool showAuthScreen = false})
    : this.showAuthScreen = showAuthScreen ?? false;
}


///
abstract class ItemState {}

///
class CreateItem extends AppState with ItemState {
  final Item item;
  const CreateItem(this.item)
    : assert(item is Item);
}

///
class ReadItem extends AppState with ItemState {
  final Item item;
  const ReadItem(this.item)
    : assert(item is Item);
}

///
class UpdateItem extends AppState with ItemState {
  final Item item;
  const UpdateItem(this.item)
    : assert(item is Item);
}