import 'package:flutter/material.dart';
import '../widgets/plug_scaffold.dart';

/// Экран критической ошибки приложения
class CriticalErrorScreen extends StatelessWidget {
  static const String route = '/error';
  
  const CriticalErrorScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      PlugScaffold(
        showAppBar: false,
        child: const Center(child: Text('Critical error'),),
      );
}
