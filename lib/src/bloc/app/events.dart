import 'package:awesome1c/src/models/app_theme.dart';
import 'package:awesome1c/src/models/item.dart';
import 'package:awesome1c/src/models/user.dart';

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