import 'dart:async';

import 'package:path/path.dart';
import 'package:soccer/model/coach.dart';
import 'package:soccer/model/league.dart';
import 'package:soccer/model/player.dart';
import 'package:soccer/model/team.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider(this.name);
  final String name;
  Database _database;

  Database get database => _database;

  Future open() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, name);
    await deleteDatabase(path);

    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(LeagueTable.create());
      await db.execute(TeamTable.create());
      await db.execute(PlayerTable.create());
      await db.execute(CoachTable.create());
    });
  }

  Future close() async => _database.close();
}
