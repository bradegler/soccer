
import 'dart:async';

import 'package:soccer/model/coach.dart';
import 'package:soccer/repository/provider/coach_provider.dart';


class CoachRepository {
  CoachRepository(this.provider);
  final CoachProvider provider;

  Future<List<Coach>> fetchCoachs(int leagueId) => provider.fetchByGroup(leagueId);
  Future<Coach> fetchCoach(int teamId) => provider.fetchItem(teamId);
  Future<Coach> insertCoach(Coach team) => provider.insert(team);
}