import 'package:flutter/material.dart';
import '../widgets/plug_scaffold.dart';

/// Пустой экран
class RootScreen extends StatelessWidget {
  static const String route = '/';

  const RootScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    PlugScaffold(
      showAppBar: false,
      child: const SizedBox(),
    );
}