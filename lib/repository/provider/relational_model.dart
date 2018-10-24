
/// Base class for a model style object which contains a 
/// unique identifier (id).
abstract class RelationalModel {
  RelationalModel({this.id});
  int id;
}

/// Base class representation of a relational database table.
/// 
/// The expectation is that the contract provided by this class
/// can be used in a generic fashion for 90% of all database 
/// access in a similar way to how a object relational mapping library would
/// opperate.
/// 
/// Sub classes of this class are expected to provide
/// * The name of the table
/// * The name of their "id" column
/// * The list of columns in the table
/// * A column which can be used for group based queries e.g. Player.teamId, Ingredient.receipeId in a parent / child style relationship.
/// * Functions to marshal and unmarshal between the model object and a map object
/// 
abstract class RelationalTableModel<T extends RelationalModel> {
  List<String> columns();
  String idColumn();
  String groupIdColumn();
  String tableName();

  T Function(Map<String, dynamic>) fromMap();
  Map<String, dynamic> Function(T) toMap();
}