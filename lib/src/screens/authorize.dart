import 'package:awesome1c/src/bloc/bloc.dart';
import 'package:awesome1c/src/widgets/plug_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Экран авторизации
class AuthorizeScreen extends StatelessWidget {
  static const String route = '/authorize';

  @override
  Widget build(BuildContext context) =>
    PlugScaffold(
      title: 'Авторизация',
      child: Center(
        child: Consumer<BlocHolder>(
          builder: (BuildContext context, BlocHolder blocHolder, Widget _) =>
            StreamBuilder<AuthorizedState>(
              stream: blocHolder.appBloc.whereState<AuthorizedState>(),
              builder: (BuildContext context, AsyncSnapshot<AuthorizedState> snapshot) =>
                blocHolder.currentUser.isEmpty
                ? _AuthButton(() => blocHolder.appBloc.add(SignIn()))
                : _CurrentUserInfo(() => blocHolder.appBloc.add(SignOut())),
            ),
        ),
      ),
    );
 
}

//
class _AuthButton extends StatelessWidget {
  final VoidCallback callback;

  const _AuthButton(this.callback);

  @override
  Widget build(BuildContext context) =>
    RaisedButton(
      child: Text('LogIn'),
      onPressed: callback,
    );
}

//
class _CurrentUserInfo extends StatelessWidget {
  final VoidCallback callback;

  _CurrentUserInfo(this.callback);

  @override
  Widget build(BuildContext context) =>
    RaisedButton(
      child: Text('LogOut'),
      onPressed: callback,
    );
}