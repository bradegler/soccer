
import 'package:soccer/repository/provider/relational_model.dart';

/// Fixed set of coach types
enum CoachType {
  HeadCoach,
  AssistantCoach,
}

class Coach extends RelationalModel {
  String firstName;
  String lastName;
  String contactEmail;
  String contactPhone;
  String image;
  int teamId;
  CoachType coachType;
  Coach();

  Coach.fromMap(Map<String, dynamic> map) {
    id = map[CoachTable.cColumnId];
    teamId = map[CoachTable.cColumnTeamId];
    firstName = map[CoachTable.cColumnFirstName];
    lastName = map[CoachTable.cColumnLastName];
    contactEmail = map[CoachTable.cColumnEmail];
    contactPhone = map[CoachTable.cColumnPhone];
    image = map[CoachTable.cColumnImage];
    coachType = CoachType.values.firstWhere((ct) => ct.index == map[CoachTable.cColumnType]);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
        CoachTable.cColumnTeamId: teamId,
        CoachTable.cColumnFirstName: firstName,
        CoachTable.cColumnLastName: lastName,
        CoachTable.cColumnEmail: contactEmail,
        CoachTable.cColumnPhone: contactPhone,
        CoachTable.cColumnImage: image,
        CoachTable.cColumnType: coachType.index,
    };
    if(id != null) {
      map[CoachTable.cColumnId] = id;
    }
    return map;
  }
}

class CoachTable extends RelationalTableModel<Coach> {
  static const String cTableName = "coach";
  static const String cColumnId = "id";
  static const String cColumnTeamId = "team";
  static const String cColumnFirstName = "first_name";
  static const String cColumnLastName = "last_name";
  static const String cColumnEmail = "email";
  static const String cColumnPhone = "phone";
  static const String cColumnImage = "image";
  static const String cColumnType = "coach_type";

  List<String> columns() => [
        cColumnId,
        cColumnTeamId,
        cColumnFirstName,
        cColumnLastName,
        cColumnEmail,
        cColumnPhone,
        cColumnImage,
        cColumnType,
      ];

  static String create() => '''
    create table $cTableName ( 
    $cColumnId integer primary key autoincrement, 
    $cColumnTeamId integer not null,
    $cColumnFirstName text not null,
    $cColumnLastName text not null,
    $cColumnType integer not null,
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
  fromMap() => (map) => Coach.fromMap(map);

  @override
  toMap() => (item) => item.toMap();
}