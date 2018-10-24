import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soccer/model/league.dart';
import 'package:soccer/model/team.dart';
import 'package:soccer/presentation/component/block_header.dart';
import 'package:soccer/presentation/component/color_picker.dart';
import 'package:soccer/presentation/router_provider.dart';
import 'package:soccer/state/bloc_provider.dart';
import 'package:soccer/state/league_state.dart';
import 'package:soccer/state/team_state.dart';

class TeamCreate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TeamCreateState();
}

class _TeamCreateState extends State<TeamCreate> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  bool canSave = false;
  Color selectedColor = Colors.blue;

  int _leagueId;
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
    final LeagueState state = BlocProvider.of(context);
    return StreamBuilder(
        stream: state.currentLeague,
        builder: (context, leagueData) {
          if (leagueData.hasData) {
            final League league = leagueData.data;
            _leagueId = league.id;
            final inputTheme = Theme.of(context)
                .textTheme
                .subhead
                .copyWith(color: Colors.black87);
            final Widget content = Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(FontAwesomeIcons.chevronLeft),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                Text("Create Team",
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
                BlockHeader(child: content, color: Color(league.color)),
                Form(
                    child: Container(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Center(
                          child: TextFormField(
                        decoration: InputDecoration(labelText: "Team Name"),
                        controller: nameController,
                        style: inputTheme,
                      )),
                      Center(
                          child: TextFormField(
                        decoration:
                            InputDecoration(labelText: "Image Location"),
                        controller: imageController,
                        style: inputTheme,
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
                          style: Theme.of(context)
                              .textTheme
                              .button
                              .copyWith(color: Colors.white),
                        ),
                        onPressed: canSave ? onCreate : null,
                      ))
                    ],
                  ),
                )),
              ],
            ));
          }
          return Container();
        });
  }

  void onCreate() {
    final TeamState state = BlocProvider.of(context);
    final Router router = RouterProvider.of(context);
    final team = Team();
    team.image = imageController.value.text;
    team.name = nameController.value.text;
    team.color = selectedColor.value;
    team.leagueId = _leagueId;

    state.insertTeam(team).then((l) {
      router.navigateTo(context, "/team/display/${l.id}",
          replace: true, transition: TransitionType.fadeIn);
    });
  }
}
