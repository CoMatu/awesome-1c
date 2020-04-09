import 'dart:math' as math show min;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/item.dart';

enum ItemWidgetMode {
  create,
  read,
  update,
  unknown,
}

class ItemWidget extends StatelessWidget {
  final ItemWidgetMode mode;
  final Item item;

  const ItemWidget({
    ItemWidgetMode mode,
    this.item,
    Key key,
  }) 
    : mode = mode ?? ItemWidgetMode.unknown
    , super(key: key);
  
  @override
  Widget build(BuildContext context) =>
    LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => 
        SizedBox(
          width: math.min(constraints.maxWidth, 520),
          height: math.min(constraints.maxHeight, 520),
          child: Card(
            child: mode == ItemWidgetMode.unknown
            ? Center(
              child: Icon(Icons.error_outline, size: 128,),
            )
            : Padding(
              padding: const EdgeInsets.all(15),
              child: Provider<Item>.value(
                value: item,
                child: Form(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        const SizedBox(
                          height: 50,
                          child: Placeholder(),
                        ),
                        const Expanded(
                          flex: 1,
                          child: Placeholder(),
                        ),
                        const SizedBox(
                          height: 50,
                          child: Placeholder(),
                        ),
                        const SizedBox(
                          height: 50,
                          child: Placeholder(),
                        ),
                      ],
                    ),
                  ),
              ),
            ),
          ),
        ),
    );
}

/*
class ItemWidgetCreate {}

class ItemWidgetRead {}

class ItemWidgetUpdate {}
*/


/*
class _ItemWidgetTitle extends StatelessWidget {

  const _ItemWidgetTitle();

  @override
  Widget build(BuildContext context) =>
    const SizedBox();
}
*/