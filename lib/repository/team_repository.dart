
import 'dart:async';

import 'package:soccer/model/team.dart';
import 'package:soccer/repository/provider/team_provider.dart';

class TeamRepository {
  TeamRepository(this.provider);
  final TeamProvider provider;

  Future<List<Team>> fetchTeams(int leagueId) => provider.fetchByGroup(leagueId);
  Future<Team> fetchTeam(int teamId) => provider.fetchItem(teamId);
  Future<Team> insertTeam(Team team) => provider.insert(team);
}