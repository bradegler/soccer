

import 'package:soccer/repository/provider/relational_model.dart';

class Team extends RelationalModel {
  String name;
  String image;
  int leagueId;
  int color;

  Team();

  Team.fromMap(Map<String, dynamic> map) {
    id = map[TeamTable.cColumnId];
    leagueId = map[TeamTable.cColumnLeagueId];
    name = map[TeamTable.cColumnName];
    image = map[TeamTable.cColumnImage];
    color = map[TeamTable.cColumnColor];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {
      TeamTable.cColumnName: name,
      TeamTable.cColumnImage: image,
      TeamTable.cColumnLeagueId: leagueId,
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
  static const cColumnColor = "color";

  List<String> columns() => [
    cColumnId,
    cColumnLeagueId,
    cColumnName,
    cColumnImage,
    cColumnColor,
  ];

  static String create() =>
    '''
    create table $cTableName ( 
    $cColumnId integer primary key autoincrement, 
    $cColumnLeagueId integer not null,
    $cColumnName text not null,
    $cColumnColor integer not null,
    $cColumnImage text
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