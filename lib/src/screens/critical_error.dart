import 'package:awesome1c/src/widgets/plug_scaffold.dart';
import 'package:flutter/material.dart';

/// Экран критической ошибки приложения
class CriticalErrorScreen extends StatelessWidget {
  static const String route = '/error';

  @override
  Widget build(BuildContext context) =>
      PlugScaffold(
        showAppBar: false,
        child: Center(child: const Text('Critical error'),),
      );
}
