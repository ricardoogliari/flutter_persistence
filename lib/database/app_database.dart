import 'dart:async';
import 'package:floor/floor.dart';
import 'package:flutter_persistence/dao/item_dao.dart';
import 'package:flutter_persistence/nosql_model/nosql_item.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

//flutter packages pub run build_runner build
part 'app_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [ItemJob])
abstract class AppDatabase extends FloorDatabase {
  ItemDAO get itemDAO;
}