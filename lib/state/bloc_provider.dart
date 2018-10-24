
import 'package:flutter/material.dart';
import 'package:soccer/state/bloc_base.dart';

/// Generic BloC (Business Logic Component) Provider 
/// 
/// The provider is implemented as a [StatefulWidget] rather than [InheritedWidget]. The main
/// benefit of a [StatefulWidget] is the fact that it has a dispose method which is guaranteed 
/// to be called from which you can properly dispose of the BLoC.
/// 
/// Creation of the provider is simple
/// 
/// ```dart
/// MyBloc bloc = MyBloc();
/// BlocProvider(bloc: bloc, child: someWidget)
/// ```
/// 
/// To access the BLoC is equally simple
/// 
/// ```dart
/// MyBloc bloc = BlocProvider.of(context);
/// ```
/// 
/// You may have multiple bloc providers in your widget hierarchy.
/// 
/// ```dart
/// BlocProvider(bloc: bloc1, child: BlocProvider(bloc: bloc2, child: someWidget))
/// ```
/// 
class BlocProvider<T extends BlocBase> extends StatefulWidget {
  /// Create a new bloc provider for a given bloc. All widgets below
  /// this one in the hierarchy will be able to access the bloc.
  BlocProvider({Key key, @required this.child, @required this.bloc}) : 
    assert(child != null),
    assert(bloc != null),
    super(key: key);
    final T bloc;
    final Widget child;

  /// Retrieve the nearest instance of a BLoC of the given type from
  /// the widget hierarchy.
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
