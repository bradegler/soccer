

import 'package:soccer/repository/provider/relational_model.dart';

class Team extends RelationalModel {
  int id;
  String name;
  String image;
  String coach;
  String assistantCoach1;
  String assistantCoach2;
  String assistantCoach3;
  String assistantCoach4;
  int leagueId;
  int color;

  Team();

  Team.fromMap(Map<String, dynamic> map) {
    id = map[TeamTable.cColumnId];
    leagueId = map[TeamTable.cColumnLeagueId];
    name = map[TeamTable.cColumnName];
    image = map[TeamTable.cColumnImage];
    coach = map[TeamTable.cColumnCoach];
    assistantCoach1 = map[TeamTable.cColumnAssistantCoach1];
    assistantCoach2 = map[TeamTable.cColumnAssistantCoach2];
    assistantCoach3 = map[TeamTable.cColumnAssistantCoach3];
    assistantCoach4 = map[TeamTable.cColumnAssistantCoach4];
    color = map[TeamTable.cColumnColor];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {
      TeamTable.cColumnName: name,
      TeamTable.cColumnImage: image,
      TeamTable.cColumnLeagueId: leagueId,
      TeamTable.cColumnCoach: coach,
      TeamTable.cColumnAssistantCoach1: assistantCoach1,
      TeamTable.cColumnAssistantCoach2: assistantCoach2,
      TeamTable.cColumnAssistantCoach3: assistantCoach3,
      TeamTable.cColumnAssistantCoach4: assistantCoach4,
      TeamTable.cColumnColor: color,
    };
    if(id != null) {
      map[TeamTable.cColumnId] = id;
    }
    return map;
  }
}



class TeamTable extends RelationalTableModel<Team> {
  static const cTableName = "team";
  static const cColumnId = "id";
  static const cColumnLeagueId = "league_id";
  static const cColumnName = "name";
  static const cColumnImage = "image";
  static const cColumnCoach = "coach";
  static const cColumnAssistantCoach1 = "assistant_coach_1";
  static const cColumnAssistantCoach2 = "assistant_coach_2";
  static const cColumnAssistantCoach3 = "assistant_coach_3";
  static const cColumnAssistantCoach4 = "assistant_coach_4";
  static const cColumnColor = "color";

  List<String> columns() => [
    cColumnId,
    cColumnLeagueId,
    cColumnName,
    cColumnImage,
    cColumnCoach,
    cColumnAssistantCoach1,
    cColumnAssistantCoach2,
    cColumnAssistantCoach3,
    cColumnAssistantCoach4,
    cColumnColor,
  ];

  static String create() =>
    '''
    create table $cTableName ( 
    $cColumnId integer primary key autoincrement, 
    $cColumnLeagueId integer not null,
    $cColumnName text not null,
    $cColumnCoach text not null,
    $cColumnImage text,
    $cColumnAssistantCoach1 text,
    $cColumnAssistantCoach2 text,
    $cColumnAssistantCoach3 text,
    $cColumnAssistantCoach4 text,
    $cColumnColor integer not null
    )
    ''';

  @override
  String groupIdColumn() => cColumnLeagueId;

  @override
  String idColumn() => cColumnId;

  @override
  String tableName() => cTableName;

  @override
  fromMap() => (map) => Team.fromMap(map);

  @override
  toMap() => (item) => item.toMap();
}