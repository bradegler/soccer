import 'package:flutter/material.dart';
import 'package:soccer/state/bloc_base.dart';
import 'package:soccer/state/bloc_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  group("bloc provider", () {
    testWidgets('finds bloc in heirarchy', (tester) async {
      var gestureKey = UniqueKey();
      var bloc = _MockBloc();
      _MockBloc foundBloc;
      await tester.pumpWidget(
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return MaterialApp(
              home: Material(
                  child: BlocProvider(
                      child: _GestureHolder(
                          gestureKey: gestureKey,
                          onTap: (ctx) {
                            setState(() {
                              foundBloc = BlocProvider.of(ctx);
                            });
                          }),
                      bloc: bloc)),
            );
          },
        ),
      );
      expect(foundBloc, isNull);
      await tester.tap(find.byKey(gestureKey));
      expect(foundBloc, equals(bloc));
    });
  });
}

class _GestureHolder extends StatelessWidget {
  final Key gestureKey;
  final WidgetBuilder onTap;

  const _GestureHolder({this.gestureKey, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(key: gestureKey, onTap: () => onTap(context));
  }
}
class _MockBloc extends Mock implements BlocBase {}
