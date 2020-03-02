import 'dart:math' as math show min;
import 'package:awesome1c/src/models/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ItemWidgetMode {
  create,
  read,
  update,
  unknown,
}

class ItemWidget extends StatelessWidget {
  final ItemWidgetMode mode;
  final Item item;

  ItemWidget({
    ItemWidgetMode mode,
    Item item,
  }) 
    : this.mode = mode ?? ItemWidgetMode.unknown
    , this.item = item;
  
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
              padding: EdgeInsets.all(15),
              child: Provider<Item>.value(
                value: item,
                child: Form(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                          child: Placeholder(),
                        ),
                        Expanded(
                          flex: 1,
                          child: Placeholder(),
                        ),
                        SizedBox(
                          height: 50,
                          child: Placeholder(),
                        ),
                        SizedBox(
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

class _ItemWidgetTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
    SizedBox();
}