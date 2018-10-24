
import 'dart:async';

import 'package:soccer/repository/provider/database_provider.dart';
import 'package:soccer/repository/provider/relational_model.dart';

/// This class provides database operations supporting a [RelationalModel] object.
/// 
/// All standard CRUD operations are supported as well as fetching by a grouping identifier
/// and fetching all records of the type.
class RelationalModelProvider <T extends RelationalModel> {
  RelationalModelProvider(this.provider, this.model);

  final DatabaseProvider provider;
  final RelationalTableModel<T> model;

  Future<List<T>> fetchByGroup(int groupId) async {
    List<Map<String, dynamic>> maps = await provider.database.query(
        model.tableName(),
        columns: model.columns(),
        where: "${model.groupIdColumn()} = ?",
        whereArgs: [groupId]);
    if (maps.length > 0) {
      return maps.map((m) => model.fromMap()(m)).toList();
    }
    return null;
  }
  Future<List<T>> fetchAll() async {
    List<Map<String, dynamic>> maps = await provider.database.query(
        model.tableName(),
        columns: model.columns());
    if (maps.length > 0) {
      return maps.map((m) => model.fromMap()(m)).toList();
    }
    return null;
  }

  Future<T> fetchItem(int id) async {
    List<Map<String, dynamic>> maps = await provider.database.query(
        model.tableName(),
        columns: model.columns(),
        where: "${model.idColumn()} = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return model.fromMap()(maps.first);
    }
    return null;
  }

  Future<T> insert(T item) async {
    final int id = await provider.database.insert(model.tableName(), model.toMap()(item));
    return fetchItem(id);
  }

  Future<int> delete(int id) async {
    return await provider.database.delete(model.tableName(),
        where: "${model.idColumn()} = ?", whereArgs: [id]);
  }

  Future<int> update(T item) async {
    return await provider.database.update(model.tableName(), model.toMap()(item),
        where: "${model.idColumn()} = ?", whereArgs: [item.id]);
  }
}
