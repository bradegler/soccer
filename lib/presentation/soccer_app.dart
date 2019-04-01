import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:soccer/presentation/app_theme.dart';
import 'package:soccer/presentation/route_builder.dart';
import 'package:soccer/presentation/router_provider.dart';
import 'package:soccer/repository/coach_repository.dart';
import 'package:soccer/repository/player_repository.dart';
import 'package:soccer/repository/provider/coach_provider.dart';
import 'package:soccer/repository/provider/database_provider.dart';
import 'package:soccer/repository/provider/league_provider.dart';
import 'package:soccer/repository/league_repository.dart';
import 'package:soccer/repository/provider/player_provider.dart';
import 'package:soccer/repository/provider/team_provider.dart';
import 'package:soccer/repository/team_repository.dart';
import 'package:soccer/state/bloc_provider.dart';
import 'package:soccer/state/coach_state.dart';
import 'package:soccer/state/league_state.dart';
import 'package:soccer/state/player_state.dart';
import 'package:soccer/state/team_state.dart';

class SoccerApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SoccerAppState();
}

class _SoccerAppState extends State<SoccerApp> {
  DatabaseProvider _provider;
  Router _router;
  @override
  void initState() {
    super.initState();
    _provider = DatabaseProvider("pickatto_soccer.db");
    _provider.open();
    _router = RouterBuilder().build();
  }

  @override
  void dispose() {
    _provider.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(title: "Soccer Manager", onGenerateRoute: _router.generator, initialRoute: "/", theme: AppTheme().themeData);

    // @TODO - This feels extremely ugly. There has to be a better way to manage multiple
    // BLoC objects rather than just chaining them together like this.
    // Pushing them deeper into the widget tree seems great on paper but then you have to deal
    // with getting the dependency on the database provider somehow pushed down to whatever
    // widget would ultimately create the BLoC if it is moved from here.
    return RouterProvider(
        router: _router,
        child: BlocProvider<LeagueState>(
          bloc: LeagueState(LeagueRepository(LeagueProvider(_provider))),
          child: BlocProvider<TeamState>(
            bloc: TeamState(TeamRepository(TeamProvider(_provider))),
            child: BlocProvider<PlayerState>(
              bloc: PlayerState(PlayerRepository(PlayerProvider(_provider))),
              child: BlocProvider<CoachState>(bloc: CoachState(CoachRepository(CoachProvider(_provider))), child: app),
            ),
          ),
        ));
  }
}
