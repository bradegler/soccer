

import 'package:soccer/repository/provider/relational_model.dart';

class League extends RelationalModel {
  String name;
  String image;
  int color;

  League();

  League.fromMap(Map<String, dynamic> map) {
    id = map[LeagueTable.cColumnId];
    name = map[LeagueTable.cColumnName];
    image = map[LeagueTable.cColumnImage];
    color = map[LeagueTable.cColumnColor];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {
      LeagueTable.cColumnName: name,
      LeagueTable.cColumnImage: image,
      LeagueTable.cColumnColor: color,
    };
    if(id != null) {
      map[LeagueTable.cColumnId] = id;
    }
    return map;
  }
}

class LeagueTable extends RelationalTableModel<League> {
  static const cTableName = "league";
  static const cColumnId = "id";
  static const cColumnName = "name";
  static const cColumnImage = "image";
  static const cColumnColor = "color";

  List<String> columns() => [
    cColumnId,
    cColumnName,
    cColumnImage,
    cColumnColor,
  ];

  static String create() =>
    '''
    create table $cTableName ( 
    $cColumnId integer primary key autoincrement, 
    $cColumnName text not null,
    $cColumnColor integer not null,
    $cColumnImage text
    )
    ''';

  @override
  String groupIdColumn() => null;

  @override
  String idColumn() => cColumnId;

  @override
  String tableName() => cTableName;

  @override
  fromMap() => (map) => League.fromMap(map);

  @override
  toMap() => (item) => item.toMap();

}