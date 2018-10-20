
import 'dart:async';

import 'package:soccer/model/team.dart';
import 'package:soccer/repository/team_repository.dart';
import 'package:soccer/state/bloc_base.dart';
import 'package:rxdart/rxdart.dart';

class TeamState extends BlocBase {
  TeamState(this.repository);
  final TeamRepository repository;

  final _teamsSubject = BehaviorSubject<List<Team>>();
  final _teamSubject = BehaviorSubject<Team>();

  Stream<List<Team>> get teams => _teamsSubject.stream;
  Stream<Team> get currentTeam => _teamSubject.stream;

  Future fetchTeams(int leagueId) async {
    repository.fetchTeams(leagueId).then(_teamsSubject.sink.add);
  }

  Future fetchTeam(int teamId) async {
    Team team = await repository.fetchTeam(teamId);
    _teamSubject.sink.add(team);
  }

  Future<Team> insertTeam(Team team) async {
    Team t = await repository.insertTeam(team);
    fetchTeams(t.leagueId);
    return Future.value(t);
  }

  @override
  void dispose() {
    _teamsSubject.close();
    _teamSubject.close();
  }

}