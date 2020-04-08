import '../../models/app_theme.dart';
import '../../models/item.dart';
import '../../models/user.dart';

/* EVENTS */

/// Корневой класс событий приложения
abstract class AppEvent {
  const AppEvent();
}

/// Начать инициализацию приложения
class InitApp extends AppEvent {
  const InitApp();
}

/// Сменить тему
class ChangeAppTheme extends AppEvent {
  final AppTheme appTheme;
  const ChangeAppTheme(this.appTheme);
}

/// Сменить язык
class ChangeLocale extends AppEvent {
  final String languageCode;
  const ChangeLocale(this.languageCode);
}

/// Авторизоваться
class SignIn extends AppEvent {
  const SignIn();
}

/// Деавторизоваться
class SignOut extends AppEvent {
  const SignOut();
}

/// Установить статус авторизации
class SetAuthState extends AppEvent {
  final User user;
  bool get authorized => user?.isNotEmpty ?? false;
  const SetAuthState(this.user);
}

/// Не указывать для создания нового элемента
class HandleItemSelection extends AppEvent {
  final Item item;
  const HandleItemSelection({this.item});
}