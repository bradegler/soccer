
import 'dart:async';

import 'package:soccer/model/league.dart';
import 'package:soccer/repository/provider/league_provider.dart';

class LeagueRepository {
  LeagueRepository(this.provider);
  final LeagueProvider provider;

  Future<List<League>> fetchLeagues() async => provider.fetchAll();
  Future<League> insertLeague(League league) async => provider.insert(league);
  Future<League> fetchLeague(int leagueId) async => provider.fetchItem(leagueId);
}