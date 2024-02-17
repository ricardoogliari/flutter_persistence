import 'package:flutter/material.dart';
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
                //_closeDialog();
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

    //_buildRows();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
