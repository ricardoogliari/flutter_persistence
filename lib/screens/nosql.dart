import 'package:flutter/material.dart';
import 'package:flutter_persistence/dao/item_dao.dart';
import 'package:flutter_persistence/database/app_database.dart';
import 'package:flutter_persistence/nosql_model/nosql_item.dart';

class NoSQLScreen extends StatefulWidget {

  NoSQLScreen({super.key});

  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();

  @override
  State<NoSQLScreen> createState() => _NoSQLScreenState();

}

class _NoSQLScreenState extends State<NoSQLScreen> {

  late SimpleDialog dialog;

  late AppDatabase _database;
  late ItemDAO _itemDAO;

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
                  labelText: "Position",
                ),
                controller: widget._positionController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Company",
                ),
                controller: widget._companyController,
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

  void _openDatabase() async{
    _database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    _itemDAO = _database.itemDAO;

    _buildRows();
  }

  void _closeDialog() async {
    Navigator.pop(context);
    ItemJob item = ItemJob(
        position: widget._positionController.text,
        company: widget._companyController.text
    );
    item.id = await _insert(item);

    setState(() {
      rows.add(
          DataRow(
              key: ValueKey(item.id),
              cells: [
                DataCell(Text(item.position)),
                DataCell(Text(item.company)),
              ],
              onLongPress: (){
                _delete(item);
              }
          )
      );
    });
  }

  Future<int> _insert(ItemJob item) async {
    int id = await _itemDAO.insertItem(item);
    return id;
  }

  Future<void> _delete(ItemJob item) async {
    await _itemDAO.deleteItem(item);

    _buildRows();
  }

  void _buildRows() async {
    List<ItemJob> itens = await _itens();
    setState(() {
      rows = itens.map((item) =>
          DataRow(
              key: ValueKey(item.id),
              cells: [
                DataCell(Text(item.position)),
                DataCell(Text(item.company)),
              ], onLongPress: (){
            _delete(item);
          }
          )
      ).toList();
    });
  }

  Future<List<ItemJob>> _itens() async {
    final List<ItemJob> itens = await _itemDAO.findAll();

    return itens;
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
