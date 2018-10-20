
import 'dart:async';

import 'package:soccer/model/player.dart';
import 'package:soccer/repository/provider/player_provider.dart';


class PlayerRepository {
  PlayerRepository(this.provider);
  final PlayerProvider provider;

  Future<List<Player>> fetchPlayers(int leagueId) => provider.fetchByGroup(leagueId);
  Future<Player> fetchPlayer(int teamId) => provider.fetchItem(teamId);
  Future<Player> insertPlayer(Player team) => provider.insert(team);
}