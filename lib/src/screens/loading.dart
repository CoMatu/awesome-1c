import 'package:flutter/material.dart';
import '../widgets/plug_scaffold.dart';

/// Экран загрузки
class LoadingScreen extends StatefulWidget {
  static const String route = '/loading';

  const LoadingScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoadingScreenState();
}
class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) =>
    PlugScaffold(
      showAppBar: false,
      child: const Center(child: CircularProgressIndicator(),),
    );
}