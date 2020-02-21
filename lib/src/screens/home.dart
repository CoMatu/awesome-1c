
import 'package:awesome1c/src/widgets/plugScaffold.dart';
import 'package:flutter/material.dart';

/// Домашний экран
class HomeScreen extends StatefulWidget {
  static const String route = '/home';

  const HomeScreen();
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    this._textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) =>
    PlugScaffold(
      title: '1C:Awesome',
      searchController: this._textEditingController,
      child: Container(
        color: Colors.red,
        child: Center(child: const Text('ListView',),),
      ),
      extraChild: Container(
        color: Colors.green,
        child: Center(child: const Text('Content',),),
      ),
    );
}