import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

class RouterProvider extends InheritedWidget {
  RouterProvider({Key key, this.router, Widget child})
      : super(key: key, child: child);
  final Router router;

  static Router of(BuildContext context) {
    final RouterProvider provider =
        context.inheritFromWidgetOfExactType(RouterProvider);
    return provider.router;
  }

  @override
  bool updateShouldNotify(RouterProvider oldWidget) =>
      oldWidget.router != this.router;
}
