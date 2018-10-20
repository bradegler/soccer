
abstract class RelationalModel {
  RelationalModel({this.id});
  int id;
}

abstract class RelationalTableModel<T extends RelationalModel> {
  List<String> columns();
  String idColumn();
  String groupIdColumn();
  String tableName();

  T Function(Map<String, dynamic>) fromMap();
  Map<String, dynamic> Function(T) toMap();
}