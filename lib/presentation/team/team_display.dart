import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_fab_dialer/flutter_fab_dialer.dart';
import 'package:soccer/model/player.dart';
import 'package:soccer/model/team.dart';
import 'package:soccer/presentation/component/block_header.dart';
import 'package:soccer/presentation/router_provider.dart';
import 'package:soccer/presentation/team/team_coach_panel.dart';
import 'package:soccer/state/bloc_provider.dart';
import 'package:soccer/state/coach_state.dart';
import 'package:soccer/state/player_state.dart';
import 'package:soccer/state/team_state.dart';

class TeamDisplay extends StatefulWidget {
  TeamDisplay({Key key, this.teamId}) : super(key: key);
  final int teamId;

  @override
  State<StatefulWidget> createState() => _TeamDisplay();
}

class _TeamDisplay extends State<TeamDisplay> {
  @override
  void initState() {
    super.initState();
    final TeamState state = BlocProvider.of(context);
    state.fetchTeam(widget.teamId);
    final PlayerState playerState = BlocProvider.of(context);
    playerState.fetchPlayers(widget.teamId);
    final CoachState coachState = BlocProvider.of(context);
    coachState.fetchCoachs(widget.teamId);
  }

  List<FabMiniMenuItem> _getFabMenuItems(int teamId) {
   return [
      FabMiniMenuItem.withText(
        Icon(FontAwesomeIcons.plusCircle),
        Theme.of(context).accentColor,
        4.0,
        "Add",
        () {
          Router router = RouterProvider.of(context);
          router.navigateTo(context, "/player/create");
        },
        "Add Player",
        Theme.of(context).accentColor,
        Colors.white,
        true
      ),
      FabMiniMenuItem.withText(
        Icon(FontAwesomeIcons.clipboardList),
        Theme.of(context).accentColor,
        4.0,
        "Add",
        () {
          Router router = RouterProvider.of(context);
          router.navigateTo(context, "/team/$teamId/coach/create");
        },
        "Add Coach",
        Theme.of(context).accentColor,
        Colors.white,
        true
      ),
   ];
  }

  @override
  Widget build(BuildContext context) {
    final TeamState state = BlocProvider.of(context);
    return StreamBuilder(
        stream: state.currentTeam,
        builder: (context, data) {
          if (data.hasData) {
            final Team team = data.data;
            final String logo = team.image.length > 0
                ? team.image
                : "https://place-hold.it/64x64";
            final Widget content = Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(FontAwesomeIcons.chevronLeft),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                Text(team.name,
                    style: Theme.of(context)
                        .textTheme
                        .subhead
                        .copyWith(color: Colors.white)),
                Image.network(
                  logo,
                  height: 64.0,
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            );
            return Scaffold(
                body: Stack(
                  children: <Widget>[
                    Column(children: <Widget>[
                      Hero(
                          child:
                              BlockHeader(child: content, color: Color(team.color)),
                          tag: "team-${team.id}"),
                      TeamCoachPanel(),
                      playerList(context),
                    ]),
                    new FabDialer(_getFabMenuItems(team.id), Theme.of(context).accentColor, Icon(FontAwesomeIcons.plusCircle)),
                  ],
                ));
          }
          return Container();
        });
  }

  Widget playerList(BuildContext context) {
    final PlayerState playerState = BlocProvider.of(context);
    return StreamBuilder(
        stream: playerState.players,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Player> players = snapshot.data;
            final Router router = RouterProvider.of(context);
            return Expanded(
                child: ListView.builder(
              shrinkWrap: true,
              itemCount: players.length,
              itemBuilder: (context, idx) {
                final Player player = players[idx];
                final Widget content = Row(
                  children: <Widget>[
                    Text(
                        "${player.firstName} ${player.lastName} (${player.nickname})",
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: Colors.white)),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                );
                return GestureDetector(
                    child: Hero(
                        child: BlockHeader(
                          child: content,
                          color: player.gender == "Male"
                              ? Colors.blue
                              : Colors.pink,
                          margin: EdgeInsets.only(
                              left: 4.0, right: 4.0, top: 4.0, bottom: 8.0),
                        ),
                        tag: "player-${player.id}"),
                    onTap: () {
                      router.navigateTo(context, "/team/player/${player.id}",
                          transition: TransitionType.fadeIn,
                          transitionDuration: Duration(seconds: 1));
                    });
              },
            ));
          }
          return Container();
        });
  }


}
