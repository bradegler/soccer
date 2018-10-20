import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:soccer/model/league.dart';
import 'package:soccer/presentation/component/block_header.dart';
import 'package:soccer/presentation/component/image_header.dart';
import 'package:soccer/presentation/router_provider.dart';
import 'package:soccer/state/bloc_provider.dart';
import 'package:soccer/state/league_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LeaguesRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LeaguesRouteState();
}

class _LeaguesRouteState extends State<LeaguesRoute> {
  @override
  void initState() {
    super.initState();
    final LeagueState state = BlocProvider.of(context);
    state.fetchLeagues();
  }

  @override
  Widget build(BuildContext context) {
    final LeagueState state = BlocProvider.of(context);
    final Router router = RouterProvider.of(context);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              router.navigateTo(context, "/league/create", transition: TransitionType.fadeIn, transitionDuration: Duration(seconds: 1));
            },
            child: Icon(FontAwesomeIcons.plus)),
        body: Column(
          children: <Widget>[
            ImageHeader(image: "assets/field_header.jpg", text: "My Leagues"),
            Container(
                child: StreamBuilder(
                    stream: state.leagues,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final List<League> leagues = snapshot.data;
                        return leagueView(context, leagues);
                      }
                      return Container();
                    })),
          ],
        ));
  }

  Widget leagueView(BuildContext context, List<League> leagues) {
    final Router router = RouterProvider.of(context);
    return Expanded(
        child: ListView.builder(
      shrinkWrap: true,
      itemCount: leagues.length,
      itemBuilder: (context, idx) {
        final League league = leagues[idx];
        final String logo = league.image.length > 0
            ? league.image
            : "https://place-hold.it/64x64";
        final Widget content = Row(
          children: <Widget>[
            Text(league.name,
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
        return GestureDetector(
            child: Hero(
                child: BlockHeader(child: content, color: Color(league.color), margin: EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0, bottom: 8.0),),
                tag: "league-${league.id}"),
            onTap: () {
              router.navigateTo(context, "/league/display/${league.id}", transition: TransitionType.fadeIn, transitionDuration: Duration(seconds: 1));
            });
      },
    ));
  }


}
