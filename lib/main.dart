import 'package:flutter/material.dart';
import 'package:flutter_persistence/screens/key_value.dart';
import 'package:flutter_persistence/screens/nosql.dart';
import 'package:flutter_persistence/screens/relational.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //estamos usando rotas nomeadas, logo, o MaterialApp não tem a propriedade home e sim a:
  //initialRoute - rota inicial
  //routes - descrição das rotas e para onde elas levam

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        '/key_value': (context) => const KeyValueScreen(),
        '/relational': (context) => RelationalScreen(),
        '/nosql': (context) => const NoSQLScreen(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {

  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Persistence"),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.circle_rounded),
            trailing: const Icon(Icons.chevron_right),
            title: const Text("Key value"),
            onTap: () => Navigator.pushNamed(context, '/key_value'),
          ),
          ListTile(
            leading: const Icon(Icons.circle_rounded),
            trailing: const Icon(Icons.chevron_right),
            title: const Text("Relational"),
            onTap: () => Navigator.pushNamed(context, '/relational'),
          ),
          ListTile(
            leading: const Icon(Icons.circle_rounded),
            trailing: const Icon(Icons.chevron_right),
            title: const Text("NoSQL"),
            onTap: () => Navigator.pushNamed(context, '/nosql'),
          )
        ],
      )
    );
  }
}
