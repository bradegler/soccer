
import 'dart:async';

import 'package:soccer/model/league.dart';
import 'package:soccer/repository/league_repository.dart';
import 'package:soccer/state/bloc_base.dart';
import 'package:rxdart/rxdart.dart';

class LeagueState extends BlocBase {
  LeagueState(this.repository);
  final LeagueRepository repository;

  final _leaguesSubject = BehaviorSubject<List<League>>();
  final _leagueSubject = BehaviorSubject<League>();

  Stream<List<League>> get leagues => _leaguesSubject.stream;
  Stream<League> get currentLeague => _leagueSubject.stream;

  Future fetchLeagues() async {
    repository.fetchLeagues().then(_leaguesSubject.sink.add);
  }

  Future fetchLeague(int leagueId) async {
    League league = await repository.fetchLeague(leagueId);
    _leagueSubject.sink.add(league);
  }

  Future<League> insertLeague(League league) async {
    League l = await repository.insertLeague(league);
    await fetchLeagues();
    return Future.value(l);
  }

  @override
  void dispose() {
    _leaguesSubject.close();
    _leagueSubject.close();
  }

}