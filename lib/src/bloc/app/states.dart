import '../../models/app_theme.dart';
import '../../models/item.dart';
import '../../models/user.dart';

/* STATES */

/// Корневой класс состояний приложения
abstract class AppState {
  const AppState();
}

/// Класс отмечающий состояния как влияющие на автороутинг
mixin AppRoutingState {}

/// Начальное состояние приложения
class InitialAppState extends AppState with AppRoutingState {}

/// Приложение инициализировано
class InitializedAppState extends AppState with AppRoutingState {}


/// Смена темы оформления приложения
class AppThemeChangedState extends AppState {
  final AppTheme appTheme;
  const AppThemeChangedState(this.appTheme);
}


/// Смена языка
class LocalizationState extends AppState {
  final String languageCode;
  const LocalizationState(this.languageCode);
}


///
mixin AuthorizedState {}

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
    : showAuthScreen = showAuthScreen ?? false;
}


///
mixin ItemState {}

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