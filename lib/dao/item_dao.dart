import 'package:floor/floor.dart';
import 'package:flutter_persistence/nosql_model/nosql_item.dart';

@dao
abstract class ItemDAO {

  @Query('SELECT * FROM ItemJob')
  Future<List<ItemJob>> findAll();

  @insert
  Future<int> insertItem(ItemJob item);

  @delete
  Future<int> deleteItem(ItemJob item);

}