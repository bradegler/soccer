
import 'dart:async';

import 'package:soccer/model/player.dart';
import 'package:soccer/repository/player_repository.dart';
import 'package:soccer/state/bloc_base.dart';
import 'package:rxdart/rxdart.dart';

class PlayerState extends BlocBase {
  PlayerState(this.repository);
  final PlayerRepository repository;

  final _playersSubject = BehaviorSubject<List<Player>>();
  final _playerSubject = BehaviorSubject<Player>();

  Stream<List<Player>> get players => _playersSubject.stream;
  Stream<Player> get currentPlayer => _playerSubject.stream;

  Future fetchPlayers(int teamId) async {
    repository.fetchPlayers(teamId).then(_playersSubject.sink.add);
  }

  Future fetchPlayer(int playerId) async {
    Player player = await repository.fetchPlayer(playerId);
    _playerSubject.sink.add(player);
  }

  Future<Player> insertPlayer(Player player) async {
    Player t = await repository.insertPlayer(player);
    fetchPlayers(t.teamId);
    return Future.value(t);
  }

  @override
  void dispose() {
    _playersSubject.close();
    _playerSubject.close();
  }

}