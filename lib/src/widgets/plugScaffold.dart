import 'package:awesome1c/src/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@immutable
class PlugScaffold extends StatefulWidget {
  final String title;
  final Widget child;
  final Widget extraChild;
  final bool showAppBar;
  final _AppBarSearchController _searchController;
  PlugScaffold({Key key, this.title, @required this.child, this.extraChild, bool showAppBar = true, TextEditingController searchController})
    : assert(child is Widget)
    , this.showAppBar = showAppBar ?? true
    , this._searchController = _AppBarSearchController.fromTextEditingController(searchController)
    , super(key: key);

  @override
  _PlugScaffoldState createState() => _PlugScaffoldState();  
}

class _PlugScaffoldState extends State<PlugScaffold> {
  @override
  Widget build(BuildContext context) =>
    Provider<_AppBarSearchController>.value(
      value: widget._searchController,
      child: Scaffold(
        appBar: (widget.showAppBar ?? true) ? _PlugScaffoldAppBar(title: widget.title,) : null,
        body: SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: _PlugScaffoldContent(widget.child, widget.extraChild),
          ),
        ),
        drawer: _PlugScaffoldDrawer(),
      ),
    );

}

class _PlugScaffoldAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize; // default is 56.0
  final String title;

  _PlugScaffoldAppBar({Key key, String title = ''}) 
    : preferredSize = Size.fromHeight(kToolbarHeight)
    , this.title = title ?? ''
    , super(key: key);

  @override
  State<StatefulWidget> createState() => _PlugScaffoldAppBarState();
}

class _PlugScaffoldAppBarState extends State<_PlugScaffoldAppBar> {
  /// Активирована ли строка поиска
  bool active = false;

  @override
  void initState() {
    super.initState();
    this.active = false;
  }

  @override
  Widget build(BuildContext context) =>
    AppBar(
      leading: const _PlugScaffoldLeadIcon(),
      title: this.active ? const _SearchField() : Text(widget.title),
      actions: (Provider.of<_AppBarSearchController>(context)?.isEnabled ?? false)
        ? <Widget>[
          IconButton(
            icon: this.active ? const Icon(Icons.close) : const Icon(Icons.search,),
            onPressed: _toogleSearchButton,
          ),
        ]
        : null,
    );
  
  void _toogleSearchButton() =>
    setState(() {
      this.active = !this.active;
    });
}

class _SearchField extends StatelessWidget {
  const _SearchField({Key key})
    : super(key: key);

  @override
  Widget build(BuildContext context) =>
    TextField(
      controller: Provider.of<_AppBarSearchController>(context).searchController,
      decoration: new InputDecoration(
        hintText: 'Поиск...'
      ),
    );
}

class _PlugScaffoldLeadIcon extends StatelessWidget {
  const _PlugScaffoldLeadIcon({Key key})
    : super(key: key);

  @override
  Widget build(BuildContext context) =>
    Navigator.of(context)?.canPop() ?? false
    ? IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () => this._pop(context),
    )
    : IconButton(
      icon: Icon(Icons.menu),
      onPressed: () => this._showDrawer(context),
    );

  void _showDrawer(BuildContext context) {
    final ScaffoldState _scaffoldState = Scaffold.of(context);
    if (_scaffoldState?.isDrawerOpen ?? false) return;
    _scaffoldState.openDrawer();
  }
  
  void _pop(BuildContext context) =>
    Navigator.of(context)?.pop();
}

class _PlugScaffoldDrawer extends StatelessWidget {
  _PlugScaffoldDrawer({Key key})
    : super(key: key);

  @override
  Widget build(BuildContext context) =>
    Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Text(
              'Drawer Header',
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Messages'),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => Navigator.of(context)?.pushNamed(SettingsScreen.route),
          ),
        ],
      ),
    );
}


class _PlugScaffoldContent extends StatelessWidget {
  final Widget child;
  final Widget extraChild;
  _PlugScaffoldContent(this.child, this.extraChild, {Key key})
    : super(key: key);

  @override
  Widget build(BuildContext context) =>
    LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        const double maxChildWidth = 480.0;
        const double spacerWidth = 20.0;
        final double _maxWidth = (constraints?.maxWidth ?? .0);       
        if (_maxWidth < (maxChildWidth*2+spacerWidth) || this.extraChild == null) {
          return ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: maxChildWidth),
            child: this.child,
          );
        }
        return SizedBox(
          width: maxChildWidth*2+spacerWidth,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            verticalDirection: VerticalDirection.down,
            textDirection: TextDirection.ltr,
            children: <Widget>[
              SizedBox(
                width: maxChildWidth,
                child: this.child,
              ),
              SizedBox(
                width: spacerWidth,
              ),
              SizedBox(
                width: maxChildWidth,
                child: this.extraChild,
              ),
            ],
          ),
        );
      },
    );
}

class _AppBarSearchController {
  /// Включен ли поиск
  final bool isEnabled;
  
  final TextEditingController searchController;

  _AppBarSearchController.fromTextEditingController(TextEditingController searchController)
    : this.isEnabled = searchController != null && searchController is TextEditingController
    , this.searchController = searchController;
}