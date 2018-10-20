
import 'package:flutter/material.dart';
import 'package:soccer/state/bloc_base.dart';

/// Generic BloC (Business Logic Component) Provider 
class BlocProvider<T extends BlocBase> extends StatefulWidget {
  BlocProvider({Key key, @required this.child, @required this.bloc}) : 
    assert(child != null),
    assert(bloc != null),
    super(key: key);
    final T bloc;
    final Widget child;

  static T of<T extends BlocBase>(BuildContext context) {
    final type = _typeOf<BlocProvider<T>>();
    BlocProvider<T> provider = context.ancestorWidgetOfExactType(type);
    assert(() {
      if(provider == null) {
        throw FlutterError("Request for BLoC of type $type produced no results. This indicates that the BlocProvider is not in the widget hierarchy");
      }
      return true;
    }());
    return provider.bloc;
  }

  static Type _typeOf<T>() => T;

  State<StatefulWidget> createState() => new _BlocProviderState();
}

class _BlocProviderState extends State<BlocProvider> {
  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
