import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soccer/model/league.dart';
import 'package:soccer/model/team.dart';
import 'package:soccer/presentation/component/block_header.dart';
import 'package:soccer/presentation/router_provider.dart';
import 'package:soccer/repository/image_repository.dart';
import 'package:soccer/state/bloc_provider.dart';
import 'package:soccer/state/league_state.dart';
import 'package:soccer/state/team_state.dart';

class LeagueDisplay extends StatefulWidget {
  LeagueDisplay({Key key, this.leagueId}) : super(key: key);
  final int leagueId;

  @override
  State<StatefulWidget> createState() => _LeagueDisplayState();
}

class _LeagueDisplayState extends State<LeagueDisplay> {
  ImageRepository _imgRepo = ImageRepository();
  @override
  void initState() {
    super.initState();
    final LeagueState state = BlocProvider.of(context);
    final TeamState teamState = BlocProvider.of(context);
    state.fetchLeague(widget.leagueId);
    teamState.fetchTeams(widget.leagueId);
  }

  Widget placeHolder(BuildContext context) => Image.network("https://place-hold.it/64x64", height: 64.0);

  @override
  Widget build(BuildContext context) {
    final LeagueState state = BlocProvider.of(context);
    final TeamState teamState = BlocProvider.of(context);
    final Router router = RouterProvider.of(context);
    return StreamBuilder(
        stream: state.currentLeague,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final League league = snapshot.data;
            final Widget content = Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(FontAwesomeIcons.chevronLeft),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                Text(league.name, style: Theme.of(context).textTheme.subhead.copyWith(color: Colors.white)),
                FutureBuilder(future: _imgRepo.loadImage(league.image), initialData: placeHolder(context), builder: (context, imgSnapshot) {}),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            );
            return Scaffold(
                floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      router.navigateTo(context, "/team/create");
                    },
                    child: Icon(FontAwesomeIcons.plusSquare)),
                body: Container(
                    child: Column(
                  children: <Widget>[
                    Hero(child: BlockHeader(child: content, color: Color(league.color)), tag: "league-${league.id}"),
                    StreamBuilder(
                        stream: teamState.teams,
                        builder: (context, data) {
                          if (data.hasData) {
                            List<Team> teams = data.data;
                            return teamView(context, teams);
                          }
                          return Container();
                        })
                  ],
                )));
          }
          return Container();
        });
  }

  Widget teamView(BuildContext context, List<Team> teams) {
    final Router router = RouterProvider.of(context);
    return Expanded(
        child: ListView.builder(
      shrinkWrap: true,
      itemCount: teams.length,
      itemBuilder: (context, idx) {
        final Team team = teams[idx];
        final String logo = team.image.length > 0 ? team.image : "https://place-hold.it/64x64";
        final Widget content = Row(
          children: <Widget>[
            Text(team.name, style: Theme.of(context).textTheme.subhead.copyWith(color: Colors.white)),
            Image.network(
              logo,
              height: 64.0,
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        );
        return GestureDetector(
            child: Hero(
                child: BlockHeader(
                  child: content,
                  color: Color(team.color),
                  margin: EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0, bottom: 8.0),
                ),
                tag: "team-${team.id}"),
            onTap: () {
              router.navigateTo(context, "/team/display/${team.id}", transition: TransitionType.fadeIn, transitionDuration: Duration(seconds: 1));
            });
      },
    ));
  }
}
