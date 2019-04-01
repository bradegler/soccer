import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soccer/model/league.dart';
import 'package:soccer/presentation/component/block_header.dart';
import 'package:soccer/presentation/component/color_picker.dart';
import 'package:soccer/presentation/component/image_select_field.dart';
import 'package:soccer/presentation/router_provider.dart';
import 'package:soccer/repository/image_repository.dart';
import 'package:soccer/state/bloc_provider.dart';
import 'package:soccer/state/league_state.dart';
import 'package:image/image.dart' as img;

class LeagueCreate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LeagueCreateState();
}

class _LeagueCreateState extends State<LeagueCreate> {
  final TextEditingController _nameController = TextEditingController();
  bool _canSave = false;
  Color _selectedColor = Colors.blue;
  File _imageFile;
  ImageRepository _imgRepo = ImageRepository();
  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      setState(() {
        _canSave = _nameController.value.text.length > 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final TextStyle inputStyle = textTheme.subhead.copyWith(color: Colors.black87);
    final Widget content = Row(
      children: <Widget>[
        IconButton(
            icon: Icon(FontAwesomeIcons.chevronLeft),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            }),
        Text("Add League", style: textTheme.subhead.copyWith(color: Colors.white)),
        Container(
          height: 64.0,
        )
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
    return Scaffold(
        body: Column(
      children: <Widget>[
        BlockHeader(child: content, color: theme.primaryColor),
        Form(
            child: Container(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: ImageSelectField(
                      onImageSelect: (file) => _onImageSelect(context, file),
                      preview: _imageFile != null ? Image.file(_imageFile) : null,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: EdgeInsets.only(left: 12.0),
                      child: Center(
                          child: TextFormField(
                        decoration: InputDecoration(labelText: "League Name"),
                        controller: _nameController,
                        style: inputStyle,
                      )),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Color",
                    style: inputStyle,
                  ),
                  IconButton(
                    icon: Icon(
                      FontAwesomeIcons.solidEdit,
                      color: _selectedColor,
                    ),
                    onPressed: _onColorSelect,
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              Center(
                  child: RaisedButton(
                color: theme.accentColor,
                child: Text(
                  "Save",
                ),
                onPressed: _canSave ? _onCreate : null,
              ))
            ],
          ),
        )),
      ],
    ));
  }

  void _onCreate() async {
    final LeagueState state = BlocProvider.of(context);
    final Router router = RouterProvider.of(context);
    final league = League();
    league.image = "";
    if (_imageFile != null) {
      league.image = await _imgRepo.saveImage(img.decodeImage(_imageFile.readAsBytesSync()));
    }
    league.name = _nameController.value.text;
    league.color = _selectedColor.value;
    state.insertLeague(league).then((l) {
      router.navigateTo(context, "/league/display/${l.id}", replace: true, transition: TransitionType.fadeIn);
    });
  }

  void _onColorSelect() async {
    Color color = await showDialog(context: context, builder: (context) => PrimaryColorPickerDialog());
    setState(() => _selectedColor = color);
  }

  void _onImageSelect(BuildContext context, File file) {
    if (file != null) {
      print(file.path);
      setState(() => _imageFile = file);
    }
  }
}
