import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  LoadingIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      new Opacity(
        opacity: 0.6,
        child: Container(
          color: Colors.black54,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.red)
            ),
          )
        )
      );
  }
}