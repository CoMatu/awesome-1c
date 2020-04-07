import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bloc/bloc.dart';
import '../models/user.dart';
import '../screens/screens.dart';
import 'low_resolution.dart';

@immutable
class PlugScaffold extends StatefulWidget {
  static const double maxChildWidth = 520.0;

  final String title;
  final Widget child;
  final Widget extraChild;
  final bool showAppBar;
  final double minWidth;
  final double minHeight;
  final _AppBarSearchController _searchController;
  final VoidCallback createButtonCallback;
  PlugScaffold({
    Key key, 
    this.title, 
    @required this.child, 
    this.extraChild, 
    bool showAppBar = true, 
    TextEditingController searchController, 
    this.createButtonCallback, 
    double minWidth, 
    double minHeight})
    : assert(child is Widget)
    , showAppBar = showAppBar ?? true
    , _searchController = _AppBarSearchController.fromTextEditingController(searchController)
    , minWidth = minWidth ?? 340
    , minHeight = minHeight ?? 340
    , super(key: key);

  @override
  _PlugScaffoldState createState() => _PlugScaffoldState();  
}

//
class _PlugScaffoldState extends State<PlugScaffold> {
  @override
  Widget build(BuildContext context) =>
    LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) =>
        (constraints.maxWidth > widget.minWidth && constraints.maxHeight > widget.minHeight)
        ? Provider<_AppBarSearchController>.value(
          value: widget._searchController,
          child: StreamBuilder<AuthorizedState>(
            stream: Provider.of<BlocHolder>(context).appBloc.whereState<AuthorizedState>(),
            builder: (BuildContext context, AsyncSnapshot<AuthorizedState> snapshot) =>
              Scaffold(
                appBar: (widget.showAppBar ?? true) ? _PlugScaffoldAppBar(title: widget.title,) : null,
                body: SafeArea(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: _PlugScaffoldContent(widget.child, widget.extraChild),
                  ),
                ),
                drawer: (widget.showAppBar ?? true) ? _PlugScaffoldDrawer() : null,
                floatingActionButton: widget.createButtonCallback is VoidCallback
                  ? FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: widget.createButtonCallback,
                  ) : null,
                ),
            ),
          )
        : const Scaffold(
          body: SafeArea(
            child: LowResolution(),
          ),
        ),
    );
}

//
class _PlugScaffoldAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize; // default is 56.0
  final String title;

  _PlugScaffoldAppBar({Key key, String title = ''}) 
    : preferredSize = Size.fromHeight(kToolbarHeight)
    , title = title ?? ''
    , super(key: key);

  @override
  State<StatefulWidget> createState() => _PlugScaffoldAppBarState();
}

//
class _PlugScaffoldAppBarState extends State<_PlugScaffoldAppBar> {
  /// Активирована ли строка поиска
  bool active = false;

  @override
  void initState() {
    super.initState();
    active = false;
  }

  @override
  Widget build(BuildContext context) =>
    AppBar(
      leading: const _PlugScaffoldLeadIcon(),
      title: active ? const _SearchField() : Text(widget.title),
      centerTitle: true,
      actions: (Provider.of<_AppBarSearchController>(context)?.isEnabled ?? false)
        ? <Widget>[
          IconButton(
            icon: active ? const Icon(Icons.close) : const Icon(Icons.search,),
            onPressed: _toogleSearchButton,
          ),
        ]
        : null,
    );
  
  void _toogleSearchButton() =>
    setState(() {
      active = !active;
    });
}

//
class _SearchField extends StatelessWidget {
  const _SearchField({Key key})
    : super(key: key);

  @override
  Widget build(BuildContext context) =>
    TextField(
      controller: Provider.of<_AppBarSearchController>(context).searchController,
      decoration: const InputDecoration(
        hintText: 'Поиск...'
      ),
    );
}

//
class _PlugScaffoldLeadIcon extends StatelessWidget {
  const _PlugScaffoldLeadIcon({Key key})
    : super(key: key);

  @override
  Widget build(BuildContext context) =>
    Navigator.of(context)?.canPop() ?? false
    ? IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () => _pop(context),
    )
    : IconButton(
      icon: Icon(Icons.menu),
      onPressed: () => _showDrawer(context),
    );

  void _showDrawer(BuildContext context) {
    final ScaffoldState _scaffoldState = Scaffold.of(context);
    if (_scaffoldState?.isDrawerOpen ?? false) return;
    _scaffoldState.openDrawer();
  }
  
  void _pop(BuildContext context) =>
    Navigator.of(context)?.pop();
}

//
class _PlugScaffoldDrawer extends StatelessWidget {
  _PlugScaffoldDrawer({Key key})
    : super(key: key);

  @override
  Widget build(BuildContext context) =>
    Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _PlugScaffoldDrawerHeader(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Настройки'),
            onTap: () => Navigator.of(context)?.pushNamed(SettingsScreen.route),
          ),
        ],
      ),
    );
}

//
class _PlugScaffoldDrawerHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) =>
    DrawerHeader(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Consumer<BlocHolder>(
        builder: (BuildContext context, BlocHolder blocHolder, Widget _) {
          final User currentUser = blocHolder.appBloc.currentUser;
          final ImageProvider<dynamic> image = ((currentUser?.isNotEmpty ?? false)
            ? NetworkImage(currentUser.photoUrl)
            : const AssetImage('assets/images/unauthorized_user.png')) as ImageProvider;
          return Center(
            child: SizedBox(
              width: 64,
              height: 64,
              child: _PlugScaffoldDrawerHeaderImage(
                image: image,
              ),
            ),
          );
        }
      ),
    );
}

//
class _PlugScaffoldDrawerHeaderImage extends StatelessWidget {
  final ImageProvider<dynamic> image;
  const _PlugScaffoldDrawerHeaderImage({@required this.image});

  @override
  Widget build(BuildContext context) =>
    Material(
      elevation: 3.0,
      shape: const CircleBorder(),
      clipBehavior: Clip.hardEdge,
      color: Colors.transparent,
      child: GestureDetector(
        child: Image(image: image,),
        onTap: () => Navigator.of(context).pushNamed(AuthorizeScreen.route),
      ),
    );

    /*
    Material(
      elevation: 3.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(24),
          bottomLeft: Radius.circular(8),
        ),
      ),
      clipBehavior: Clip.hardEdge,
      color: Colors.transparent,
      child: Ink.image(
        image: image,
        fit: BoxFit.cover,
        width: 64.0,
        height: 64.0,
        child: InkWell(
          onTap: () => Navigator.of(context).pushNamed(AuthorizeScreen.route),
        ),
      ),
    );
    */
}

//
class _PlugScaffoldContent extends StatelessWidget {
  final Widget child;
  final Widget extraChild;
  _PlugScaffoldContent(this.child, this.extraChild, {Key key})
    : super(key: key);

  @override
  Widget build(BuildContext context) =>
    LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) =>
        ((constraints?.maxWidth ?? .0) < (PlugScaffold.maxChildWidth*2) || extraChild == null) 
        ? ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: PlugScaffold.maxChildWidth),
            child: child,
          )
        : ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: PlugScaffold.maxChildWidth*2 + 20.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              verticalDirection: VerticalDirection.down,
              textDirection: TextDirection.ltr,
              children: <Widget>[
                SizedBox(
                  width: PlugScaffold.maxChildWidth,
                  child: child,
                ),
                const Spacer(),
                SizedBox(
                  width: PlugScaffold.maxChildWidth,
                  child: extraChild,
                ),
              ],
            ),
          ),
    );
}

class _AppBarSearchController {
  /// Включен ли поиск
  final bool isEnabled;
  
  final TextEditingController searchController;

  _AppBarSearchController.fromTextEditingController(this.searchController)
    : isEnabled = searchController != null && searchController is TextEditingController;
}