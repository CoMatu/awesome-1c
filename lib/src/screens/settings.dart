
import 'package:awesome1c/src/widgets/plugScaffold.dart';
import 'package:flutter/material.dart';

/// Экран настроек
class SettingsScreen extends StatefulWidget {
  static const String route = '/settings';  
  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}
class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) =>
    PlugScaffold(
      title: 'Настройки',
      child: Center(
        child: Text('НАСТРОЙКИ'),
      ),
    );
}