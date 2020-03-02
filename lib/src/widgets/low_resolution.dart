import 'package:flutter/material.dart';

class LowResolution extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
    const Center(
        child: Text('Low screen resoulution', maxLines: 1, overflow: TextOverflow.ellipsis, textScaleFactor: 0.8,),
      );
}