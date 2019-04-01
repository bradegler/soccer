import 'package:flutter/material.dart';

/// Fixed height "floating" header with shadows.
class BlockHeader extends StatelessWidget {
  const BlockHeader({Key key, this.child, this.color, this.margin}) : super(key: key);
  final Widget child;
  final Color color;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 48.0, horizontal: 12.0),
        margin: margin != null ? margin : EdgeInsets.only(bottom: 8.0),
        child: child,
        decoration: BoxDecoration(color: color, boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 2.0, offset: Offset(1.0, 3.0), spreadRadius: 2.0),
          BoxShadow(color: Colors.grey.shade500, blurRadius: 5.0, offset: Offset(2.0, 6.0), spreadRadius: 2.0)
        ]));
  }
}
