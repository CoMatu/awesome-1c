
import 'package:awesome1c/src/widgets/plugScaffold.dart';
import 'package:flutter/material.dart';

/// Экран загрузки
class LoadingScreen extends StatefulWidget {
  static const String route = '/loading';  
  @override
  State<StatefulWidget> createState() => _LoadingScreenState();
}
class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) =>
    PlugScaffold(
      showAppBar: false,
      child: Center(child: CircularProgressIndicator(),),
    );
}