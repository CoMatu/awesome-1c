import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'bloc/bloc.dart';
import 'bloc/plague_bloc_delegate.dart';
import 'models/app_theme.dart';
import 'repository/localizer.dart';
import 'repository/logger.dart';
import 'repository/platform.dart';
import 'screens/screens.dart';

/// Запуск приложения
void start() {
  final Log _log = Log();
  _log.v('Приложение запускается');
  BlocSupervisor.delegate = PlagueBlocDelegate();
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(const GlobalContext(key: Key('GlobalContext')));
}

/// Глобальный контекст приложения
class GlobalContext extends StatelessWidget {
  const GlobalContext({Key key})
    : super(key: key);
  @override
  Widget build(BuildContext context) =>
    MultiProvider(
      key: const Key('GlobalContextProvider'),
      providers: <Provider>[
        Provider<BlocHolder>(
          create: (_) => BlocHolder(),
          dispose: (_, BlocHolder bloc) => bloc.close(),
        ),
        Provider<AppNavigator>(
          create: (_) => AppNavigator(), 
          dispose: (_, AppNavigator appNavigator) => appNavigator.dispose(),
        ),
        Provider<Platform>(
          create: (_) => Platform(),
        ),
        Provider<Log>(
          create: (_) => Log(),
        ),
      ],
      child: const App(key: Key('App')),
    );
}

/// Приложение
class App extends StatelessWidget {
  const App({Key key})
    : super(key: key);
  @override
  Widget build(BuildContext context) {
    final AppNavigator _appNavigator = Provider.of<AppNavigator>(context);
    // ignore: close_sinks
    final AppBloc _appBloc = Provider.of<BlocHolder>(context)
      .appBloc
        ..add(const InitApp())
        ..whereState<AppRoutingState>()
          .forEach(_appNavigator.routeFromState);
    // Обновление локали
    return StreamBuilder<LocalizationState>(
      initialData: LocalizationState(Localizer.defaultLocale.languageCode),
      stream: _appBloc.whereState<LocalizationState>(),
      builder: (BuildContext context, AsyncSnapshot<LocalizationState> localeSnapshot) =>
        // Изменение темы оформления
        StreamBuilder<AppThemeChangedState>(
          initialData: AppThemeChangedState(AppTheme.vanilla()),
          stream: _appBloc.whereState<AppThemeChangedState>(),
          builder: (BuildContext ctx, AsyncSnapshot<AppThemeChangedState> themeSnapshot) =>
            MaterialApp(
              key: const Key('MaterialApp'),
              navigatorKey: _appNavigator.navigatorKey,
              title: '1C:Awesome',
              initialRoute: '/',
              onGenerateRoute: _appNavigator.onGenerateRoute,
              theme: themeSnapshot?.data?.appTheme?.themeData ?? AppTheme.defaultThemeData,
              locale: Locale(localeSnapshot?.data?.languageCode ?? 'en'),
              //debugShowCheckedModeBanner: false,
              supportedLocales: Localizer.supportedLocales,
              localizationsDelegates: const <LocalizationsDelegate>[
                LocalizerDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
            ),
        ),
    );
  }
}

/// Навигатор приложения
class AppNavigator {
  NavigatorState get navigator => _navigatorKey?.currentState;
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  /// Роутер для MaterialApp
  Route<void> onGenerateRoute(RouteSettings routeSettings) =>
    _innerRouter(routeSettings);
  /// Производит автороутинг из состояния приложения
  void routeFromState(AppRoutingState state) {
    if (state is InitialAppState) {
      navigator.pushNamedAndRemoveUntil(LoadingScreen.route, (Route<void> route) => false);
    } else if (state is InitializedAppState) {
      navigator.pushNamedAndRemoveUntil(HomeScreen.route, (Route<void> route) => false);
    } else if (state is NotAuthorized) {
      if (!state.showAuthScreen) return;
      navigator.pushNamed(AuthorizeScreen.route,);
    }
  }
  void dispose() =>    
    navigator?.dispose();
  Route<void> _innerRouter(RouteSettings settings) {
    Widget _selectScreen(RouteSettings settings) {
      switch (settings.name) {
        case RootScreen.route: return const RootScreen();
        case HomeScreen.route: return const HomeScreen();
        case LoadingScreen.route: return const LoadingScreen();
        case SettingsScreen.route: return const SettingsScreen();
        case CriticalErrorScreen.route: return const CriticalErrorScreen();
        case AuthorizeScreen.route: return const AuthorizeScreen();
        default: return const NotFoundScreen();
      }
    }
    Route<void> _buildMaterialPageRoute(Widget screen, [RouteSettings settings, bool maintainState = true, bool fullscreenDialog = false]) =>
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => screen,
        settings: settings ?? const RouteSettings(),
        maintainState: maintainState,
        fullscreenDialog: fullscreenDialog,
      );
    final Widget screen = _selectScreen(settings);
    final Route<void> route = _buildMaterialPageRoute(screen, settings);
    return route;
  }
  /* SINGLETON + */
  static final AppNavigator _internalSingletonAppNavigator = AppNavigator._singleton();
  factory AppNavigator() => _internalSingletonAppNavigator;
  AppNavigator._singleton();
  /* SINGLETON - */
}