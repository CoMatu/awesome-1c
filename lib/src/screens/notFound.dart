import 'package:awesome1c/src/widgets/plugScaffold.dart';
import 'package:flutter/material.dart';

/// Экран отсутсвующего контента
class NotFoundScreen extends StatelessWidget {
  static const String route = '/notfound';

  @override
  Widget build(BuildContext context) =>
    PlugScaffold(
      title: '404: Not Found',
      child: Center(
        child: Text('404: Not Found'),
      ),
    );
}