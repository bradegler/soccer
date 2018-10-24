import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

/// Inherited widget which holds the Fluro router object
/// 
/// This allows widgets deeper in the chain the ability to
/// use the main router object to perform transitions without
/// needing to fall back on the standard [Navigator].
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
