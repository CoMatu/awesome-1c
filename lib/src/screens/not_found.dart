import 'package:flutter/material.dart';
import '../widgets/plug_scaffold.dart';

/// Экран отсутсвующего контента
class NotFoundScreen extends StatelessWidget {
  static const String route = '/notfound';

  const NotFoundScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    PlugScaffold(
      title: '404: Not Found',
      child: const Center(
        child: Text('404: Not Found'),
      ),
    );
}