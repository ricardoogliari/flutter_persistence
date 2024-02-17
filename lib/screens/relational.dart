import 'package:flutter/material.dart';
import 'package:flutter_persistence/relational_model/relational_item.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class RelationalScreen extends StatefulWidget {
  RelationalScreen({super.key});

  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _receptorController = TextEditingController();

  @override
  State<RelationalScreen> createState() => _RelationalScreenState();
}

class _RelationalScreenState extends State<RelationalScreen> {

  late SimpleDialog dialog;

  late Database _database;

  List<DataRow> rows = [];

  @override
  void initState() {
    super.initState();
    dialog = SimpleDialog(
      title: const Text('Novo item'),
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Quantidade",
                ),
                keyboardType: TextInputType.number,
                controller: widget._quantityController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Descrição",
                ),
                controller: widget._descriptionController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Receptor",
                ),
                controller: widget._receptorController,
              ),
              ElevatedButton(onPressed: (){
                _closeDialog();
              }, child: const Text("Inserir"))
            ],
          ),
        )
      ],
    );
    _openDatabase();
  }

  void _openDatabase() async {
    _database = await openDatabase(
      path.join(await getDatabasesPath(), 'database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE itens(id INTEGER PRIMARY KEY AUTOINCREMENT, quantity REAL, description TEXT, receptor TEXT)',
        );
      },
      version: 1,
    );

    _buildRows();
  }

  void _buildRows() async {
    List<RelationalItem> itens = await _itens();
    setState(() {
      rows = itens.map((item) =>
          DataRow(
              key: ValueKey(item.id),
              cells: [
                DataCell(Text("${item.quantity}")),
                DataCell(Text(item.description)),
                DataCell(Text(item.receptor)),
              ],
              onLongPress: (){
                _delete(item.id ?? 0);
              }
          )
      ).toList();
    });
  }

  void _closeDialog() async{
    Navigator.pop(context);
    RelationalItem item = RelationalItem(
        description: widget._descriptionController.text,
        quantity: double.parse(widget._quantityController.text),
        receptor: widget._receptorController.text
    );
    item.id = await _insert(item);

    setState(() {
      rows.add(
          DataRow(
              key: ValueKey(item.id),
              cells: [
                DataCell(Text("${item.quantity}")),
                DataCell(Text(item.description)),
                DataCell(Text(item.receptor)),
              ],
              onLongPress: (){
                _delete(item.id ?? 0);
              }
          )
      );
    });
  }

  Future<int> _insert(RelationalItem item) async {
    int id = await _database.insert(
      'itens',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<List<RelationalItem>> _itens() async {
    final List<Map<String, dynamic>> maps = await _database.query('itens');

    return List.generate(maps.length, (i) {
      return RelationalItem(
        id: maps[i]['id'] as int,
        quantity: maps[i]['quantity'] as double,
        description: maps[i]['description'] as String,
        receptor: maps[i]['receptor'] as String,
      );
    });
  }

  Future<void> _delete(int id) async {
    await _database.delete(
      'itens',
      where: 'id = ?',
      whereArgs: [id],
    );

    _buildRows();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
