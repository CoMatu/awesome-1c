import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bloc/bloc.dart';
import '../repository/localizer.dart';
import '../widgets/item_widget.dart';
import '../widgets/items_list_widget.dart';
import '../widgets/plug_scaffold.dart';

/// Домашний экран
class HomeScreen extends StatefulWidget {
  static const String route = '/home';

  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState(); // TODO: показать экран с подсказками, предложить установить мобильное приложение
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) =>
    Consumer<BlocHolder>(
      builder: (BuildContext context, BlocHolder blocHolder, Widget _) =>
        PlugScaffold(
          title: Localizer.of(context)['title'],
          searchController: _textEditingController,
          createButtonCallback: () => blocHolder?.appBloc?.add(const HandleItemSelection()),
          child: const ItemsListWidget(),
          extraChild: Center(
            child: StreamBuilder<ItemState>( 
              stream: blocHolder?.appBloc?.whereState<ItemState>(),
              builder: (BuildContext context, AsyncSnapshot<ItemState> snap) {
                final ItemState _state = snap?.data;
                if (_state is ReadItem) {
                  return ItemWidget(item: _state.item, mode: ItemWidgetMode.read,);
                } else if (_state is UpdateItem) {
                  return ItemWidget(item: _state.item, mode: ItemWidgetMode.update,);
                } else if (_state is CreateItem) {
                  return ItemWidget(item: _state.item, mode: ItemWidgetMode.create,);
                } else {
                  return const ItemWidget(mode: ItemWidgetMode.unknown,);
                }
              }
            ),
          ),
        ),
    );
}