import 'package:flutter/material.dart';

/// Fixed height floating header which displays an image
class ImageHeader extends StatelessWidget {
  const ImageHeader({Key key, this.image, this.text}) : super(key: key);
  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    final img = Image.asset(image, height: 300.0, fit: BoxFit.cover);
    return Row(children: [
      Expanded(
          child: Stack(children: [
        Container(
            child: img,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(color: Colors.grey.shade200, blurRadius: 2.0, offset: Offset(2.0, 4.0), spreadRadius: 5.0),
              BoxShadow(color: Colors.grey.shade500, blurRadius: 5.0, offset: Offset(5.0, 8.0), spreadRadius: 5.0)
            ])),
        Positioned(bottom: 64.0, left: 14.0, child: Text(text, style: Theme.of(context).textTheme.headline.copyWith(color: Colors.white)))
      ]))
    ]);
  }
}
