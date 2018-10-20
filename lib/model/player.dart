
import 'package:soccer/repository/provider/relational_model.dart';

class Player extends RelationalModel {
  int teamId;
  String firstName;
  String lastName;
  String nickname;
  String contactEmail;
  String contactPhone;
  String image;
  String gender;

  Player.fromMap(Map<String, dynamic> map) {
    id = map[PlayerTable.cColumnId];
    teamId = map[PlayerTable.cColumnTeamId];
    firstName = map[PlayerTable.cColumnFirstName];
    lastName = map[PlayerTable.cColumnLastName];
    nickname = map[PlayerTable.cColumnNickname];
    contactEmail = map[PlayerTable.cColumnEmail];
    contactPhone = map[PlayerTable.cColumnPhone];
    image = map[PlayerTable.cColumnImage];
    gender = map[PlayerTable.cColumnGender];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
        PlayerTable.cColumnTeamId: teamId,
        PlayerTable.cColumnFirstName: firstName,
        PlayerTable.cColumnLastName: lastName,
        PlayerTable.cColumnNickname: nickname,
        PlayerTable.cColumnEmail: contactEmail,
        PlayerTable.cColumnPhone: contactPhone,
        PlayerTable.cColumnImage: image,
        PlayerTable.cColumnGender: gender,
    };
    if(id != null) {
      map[PlayerTable.cColumnId] = id;
    }
    return map;
  }
}

class PlayerTable extends RelationalTableModel<Player> {
  static const String cTableName = "player";
  static const String cColumnId = "id";
  static const String cColumnTeamId = "team";
  static const String cColumnFirstName = "first_name";
  static const String cColumnLastName = "last_name";
  static const String cColumnNickname = "nickname";
  static const String cColumnEmail = "email";
  static const String cColumnPhone = "phone";
  static const String cColumnImage = "image";
  static const String cColumnGender = "gender";

  List<String> columns() => [
        cColumnId,
        cColumnTeamId,
        cColumnFirstName,
        cColumnLastName,
        cColumnNickname,
        cColumnEmail,
        cColumnPhone,
        cColumnImage,
        cColumnGender,
      ];

  static String create() => '''
    create table $cTableName ( 
    $cColumnId integer primary key autoincrement, 
    $cColumnTeamId integer not null,
    $cColumnFirstName text not null,
    $cColumnLastName text not null,
    $cColumnGender text not null,
    $cColumnNickname text,
    $cColumnEmail text,
    $cColumnPhone text,
    $cColumnImage text
    )
  ''';

  @override
  String groupIdColumn() => cColumnTeamId; 

  @override
  String idColumn() => cColumnId;

  @override
  String tableName() => cTableName;

  @override
  fromMap() => (map) => Player.fromMap(map);

  @override
  toMap() => (item) => item.toMap();
}
