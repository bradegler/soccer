
import 'dart:async';

import 'package:soccer/model/coach.dart';
import 'package:soccer/repository/coach_repository.dart';
import 'package:soccer/state/bloc_base.dart';
import 'package:rxdart/rxdart.dart';

class CoachState extends BlocBase {
  CoachState(this.repository);
  final CoachRepository repository;

  final _coachesSubject = BehaviorSubject<List<Coach>>();
  final _coachSubject = BehaviorSubject<Coach>();

  Stream<List<Coach>> get coaches => _coachesSubject.stream;
  Stream<Coach> get currentCoach => _coachSubject.stream;

  Future fetchCoachs(int teamId) async {
    repository.fetchCoachs(teamId).then(_coachesSubject.sink.add);
  }

  Future fetchCoach(int coachId) async {
    Coach coach = await repository.fetchCoach(coachId);
    _coachSubject.sink.add(coach);
  }

  Future<Coach> insertCoach(Coach coach) async {
    Coach t = await repository.insertCoach(coach);
    fetchCoachs(t.teamId);
    return Future.value(t);
  }

  @override
  void dispose() {
    _coachesSubject.close();
    _coachSubject.close();
  }

}