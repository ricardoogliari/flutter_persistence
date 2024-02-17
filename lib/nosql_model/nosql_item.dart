import 'package:floor/floor.dart';

@entity
class ItemJob {

  @PrimaryKey(autoGenerate: true)
  int? id;

  final String position;
  final String company;

  ItemJob({
    this.id,
    required this.position,
    required this.company,
  });

}