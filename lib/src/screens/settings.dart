import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bloc/bloc.dart';
import '../models/app_theme.dart';
import '../repository/localizer.dart';
import '../widgets/plug_scaffold.dart';

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
      title: Localizer.of(context)['settings'],
      child: ListView(
        children: <Widget>[
          const SizedBox(height: 20,),
          _ThemesList(),
          const SizedBox(height: 20,),
          const Divider(),
          const _LocaleList(),
        ],
      ),
    );
}

@immutable
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

@immutable
class _ThemeTile extends StatelessWidget {
  final String title;
  final AppTheme appTheme;
  const _ThemeTile({@required this.title, @required this.appTheme});
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

@immutable
class _LocaleList extends StatelessWidget {
  const _LocaleList();

  @override
  Widget build(BuildContext context) =>
    Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text('Язык:', textScaleFactor: 1.3,),
        const SizedBox(height: 20,),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: Localizer.supportedLanguageCodes
            .map<Widget>((String code) => _LocaleTile(code, code))
            .toList(),
        ),
      ],
    );
}

@immutable
class _LocaleTile extends StatelessWidget {
  final String languageCode;
  final String language;
  
  const _LocaleTile(this.languageCode, this.language);

  @override
  Widget build(BuildContext context) =>
    Consumer<BlocHolder>(
      builder: (BuildContext context, BlocHolder bloc, _) =>
        RaisedButton(
          child: Text(language),
          onPressed: () => bloc?.appBloc?.add(ChangeLocale(languageCode)),
        ),
    );
}