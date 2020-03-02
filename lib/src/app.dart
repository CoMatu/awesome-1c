import 'package:awesome1c/src/bloc/plague_bloc_delegate.dart';
import 'package:awesome1c/src/models/app_theme.dart';
import 'package:awesome1c/src/repository/logger.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:awesome1c/src/bloc/bloc.dart';
import 'package:awesome1c/src/screens/screens.dart';

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
      providers: [
        Provider<BlocHolder>(create: (_) => BlocHolder(), dispose: (_, BlocHolder bloc) => bloc.close(),),
        Provider<AppNavigator>(create: (_) => AppNavigator(), dispose: (_, AppNavigator appNavigator) => appNavigator.dispose(),),
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
        ..add(InitApp())
        ..whereState<AppRoutingState>()
          .forEach(_appNavigator.routeFromState);
    return StreamBuilder<AppThemeChangedState>(
      stream: _appBloc.whereState<AppThemeChangedState>(),
      builder: (BuildContext context, AsyncSnapshot<AppThemeChangedState> snapshot) =>
        MaterialApp(
          key: const Key('MaterialApp'),
          navigatorKey: _appNavigator.navigatorKey,
          title: '1C:Awesome',
          initialRoute: '/',
          onGenerateRoute: _appNavigator.onGenerateRoute,
          theme: snapshot?.data?.appTheme?.themeData ?? AppTheme.defaultThemeData,
          //debugShowCheckedModeBanner: false,
        ),
    );
  }
}

/// Навигатор приложения
class AppNavigator {
  NavigatorState get navigator => this._navigatorKey?.currentState;
  GlobalKey<NavigatorState> get navigatorKey => this._navigatorKey;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  /// Роутер для MaterialApp
  Route<void> onGenerateRoute(RouteSettings routeSettings) =>
    this._innerRouter(routeSettings);
  /// Производит автороутинг из состояния приложения
  void routeFromState(AppRoutingState state) {
    if (state is InitialAppState) {
      this.navigator.pushNamedAndRemoveUntil(LoadingScreen.route, (Route<void> route) => false);
    } else if (state is InitializedAppState) {
      this.navigator.pushNamedAndRemoveUntil(HomeScreen.route, (Route<void> route) => false);
    } else if (state is NotAuthorized) {
      if (!state.showAuthScreen) return;
      this.navigator.pushNamed(AuthorizeScreen.route,);
    }
  }
  void dispose() =>    
    this.navigator?.dispose();
  Route<void> _innerRouter(RouteSettings settings) {
    Widget _selectScreen(RouteSettings settings) {
      switch (settings.name) {
        case RootScreen.route: return RootScreen();
        case HomeScreen.route: return HomeScreen();
        case LoadingScreen.route: return LoadingScreen();
        case SettingsScreen.route: return SettingsScreen();
        case CriticalErrorScreen.route: return CriticalErrorScreen();
        case AuthorizeScreen.route: return AuthorizeScreen();
        default: return NotFoundScreen();
      }
    }
    Route<void> _buildMaterialPageRoute(Widget screen, [RouteSettings settings, bool maintainState = true, bool fullscreenDialog = false]) =>
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => screen,
        settings: settings ?? RouteSettings(),
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