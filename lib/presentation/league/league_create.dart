import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soccer/model/league.dart';
import 'package:soccer/presentation/component/block_header.dart';
import 'package:soccer/presentation/component/color_picker.dart';
import 'package:soccer/presentation/router_provider.dart';
import 'package:soccer/state/bloc_provider.dart';
import 'package:soccer/state/league_state.dart';

class LeagueCreate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LeagueCreateState();
}

class _LeagueCreateState extends State<LeagueCreate> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  bool canSave = false;
  Color selectedColor = Colors.blue;
  @override
  void initState() {
    super.initState();
    nameController.addListener(() {
      setState(() {
        canSave = nameController.value.text.length > 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final inputTheme = Theme.of(context).textTheme.subhead.copyWith(color: Colors.black87);
    final Widget content = Row(
      children: <Widget>[
        IconButton(
            icon: Icon(FontAwesomeIcons.chevronLeft),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            }),
        Text("Create League",
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(color: Colors.white)),
        Container(
          height: 64.0,
        )
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
    return Scaffold(
        body: Column(
      children: <Widget>[
        BlockHeader(child: content, color: Theme.of(context).primaryColor),
        Form(
            child: Container(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
              Center(
                  child: TextFormField(
                decoration: InputDecoration(labelText: "League Name"),
                style: inputTheme,
                controller: nameController,
              )),
              Center(
                  child: TextFormField(
                decoration: InputDecoration(labelText: "Image Location"),
                style: inputTheme,
                controller: imageController,
              )),
              Row(
                children: [
                  Text(
                    "Color",
                    style: inputTheme,
                  ),
                  IconButton(
                      icon: Icon(
                        FontAwesomeIcons.solidEdit,
                        color: selectedColor,
                      ),
                      onPressed: () async {
                        Color color = await showDialog(
                            context: context,
                            builder: (context) =>
                                PrimaryColorPickerDialog());
                        setState(() => selectedColor = color);
                      })
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              Center(
                  child: RaisedButton(
                color: Colors.green,
                child: Text(
                  "Create",
                ),
                onPressed: canSave ? onCreate : null,
              ))
            ],
          ),
        )),
      ],
    ));
  }

  void onCreate() {
    final LeagueState state = BlocProvider.of(context);
    final Router router = RouterProvider.of(context);
    final league = League();
    league.image = imageController.value.text;
    league.name = nameController.value.text;
    league.color = selectedColor.value;
    state.insertLeague(league).then((l) {
      router.navigateTo(context, "/league/display/${l.id}",
          replace: true, transition: TransitionType.fadeIn);
    });
  }
}
