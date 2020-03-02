import 'package:awesome1c/src/widgets/plug_scaffold.dart';
import 'package:flutter/material.dart';

/// Пустой экран
class RootScreen extends StatelessWidget {
  static const String route = '/';  
  @override
  Widget build(BuildContext context) =>
    PlugScaffold(
      showAppBar: false,
      child: const SizedBox(),
    );
}