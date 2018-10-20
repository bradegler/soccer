
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:soccer/presentation/app_theme.dart';
import 'package:soccer/presentation/route_builder.dart';
import 'package:soccer/presentation/router_provider.dart';
import 'package:soccer/repository/player_repository.dart';
import 'package:soccer/repository/provider/database_provider.dart';
import 'package:soccer/repository/provider/league_provider.dart';
import 'package:soccer/repository/league_repository.dart';
import 'package:soccer/repository/provider/player_provider.dart';
import 'package:soccer/repository/provider/team_provider.dart';
import 'package:soccer/repository/team_repository.dart';
import 'package:soccer/state/bloc_provider.dart';
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
    final app = 
      MaterialApp(
       title: "Soccer Manager",
       onGenerateRoute: _router.generator,
       initialRoute: "/",
       theme: AppTheme().themeData
    );

    return RouterProvider(
      router: _router,
      child: BlocProvider<LeagueState>(
        bloc: LeagueState(LeagueRepository(LeagueProvider(_provider))),
        child: BlocProvider<TeamState>(
          bloc: TeamState(TeamRepository(TeamProvider(_provider))),
          child: BlocProvider<PlayerState>(
            bloc: PlayerState(PlayerRepository(PlayerProvider(_provider))),
            child: app,
          ),
        ),
      )
    );
  }

}

