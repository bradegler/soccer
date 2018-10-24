
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

typedef void ImageSelectCallback(File file);

class ImageSelectField extends StatelessWidget {
  final ImageSelectCallback onImageSelect;

  const ImageSelectField({Key key, @required this.onImageSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleStartCapture(context),
          child: Container(
        height: 100.0,
        padding: EdgeInsets.all(4.0),
        color: Colors.grey.shade300,
        child: Icon(FontAwesomeIcons.cameraRetro, color: Colors.black87,),
      ),
    ); 
  }

  void _handleStartCapture(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    File result = await showDialog(context: context, barrierDismissible: true, builder: (context) {
      return Column(children: <Widget>[
        Row(children: <Widget>[
          RaisedButton(onPressed: () => _selectImage(context, ImageSource.camera), 
            child: Row(children: [Icon(FontAwesomeIcons.camera), Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text("Camera"),
            )]), color: theme.accentColor,),
          RaisedButton(onPressed: () => _selectImage(context, ImageSource.camera), 
            child: Row(children: [Icon(FontAwesomeIcons.images), Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text("Gallery"),
            )]), color: theme.accentColor,),
        ], mainAxisAlignment: MainAxisAlignment.spaceEvenly,)
      ], mainAxisAlignment: MainAxisAlignment.center,);
    });
    if(result != null) {
      print("Received file: ${result.path}");
      onImageSelect(result);
    }
  }

  void _selectImage(BuildContext context, ImageSource source) {
    Future<File> f = ImagePicker.pickImage(source: source, maxHeight: 128.0, maxWidth: 128.0);
    f.then((file) => Navigator.pop(context, f)).catchError((err) => Navigator.pop(context));
  }
}