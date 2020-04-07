import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bloc/bloc.dart';
import '../models/app_theme.dart';
import '../widgets/plug_scaffold.dart';

/// TODO: выводить номер версии приложения

/// Экран настроек
class SettingsScreen extends StatefulWidget {
  static const String route = '/settings';

  const SettingsScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}
class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) =>
    PlugScaffold(
      title: 'Настройки',
      child: ListView(
        children: <Widget>[
          const SizedBox(height: 20,),
          _ThemesList(),
          const SizedBox(height: 20,),
          const Divider(),
          /// TODO: выбор языка
        ],
      ),
    );
}

class _ThemesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
    Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text('Тема оформления:', textScaleFactor: 1.3,),
        const SizedBox(height: 20,),
        _ThemeTile(title: 'Vanilla', appTheme: AppTheme.vanilla()),        
        _ThemeTile(title: 'Legacy', appTheme: AppTheme.legacy()),
        _ThemeTile(title: 'Material', appTheme: AppTheme.material()),
        _ThemeTile(title: 'Simple', appTheme: AppTheme.simple()),
        _ThemeTile(title: 'Fuchsia', appTheme: AppTheme.fuchsia()),
        _ThemeTile(title: 'Darcula', appTheme: AppTheme.darcula()),
      ],
    );
}

class _ThemeTile extends StatelessWidget {
  final String title;
  final AppTheme appTheme;
  _ThemeTile({@required this.title, @required this.appTheme});
  @override
  Widget build(BuildContext context) =>
    Consumer<BlocHolder>(
      builder: (BuildContext context, BlocHolder bloc, _) =>
        ListTile(
          title: Text(title), 
          onTap: () =>
            bloc?.appBloc?.add(ChangeAppTheme(appTheme)),
        ),    
    );
}

