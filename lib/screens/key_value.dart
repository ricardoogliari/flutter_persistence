import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_persistence/util/capitals.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyValueScreen extends StatefulWidget {

  const KeyValueScreen({super.key});

  @override
  State<KeyValueScreen> createState() => _KeyValueScreenState();

}

class _KeyValueScreenState extends State<KeyValueScreen> {

  final String ATTEMPTS_KEY = "attempts";
  final String HITS_KEY = "hits";
  final String ERRORS_KEY = "errors";

  Random random = Random();

  final List<int> _availables = List.generate(27, (index) => index);

  late SharedPreferences prefs;

  int attempts = -1;
  int hits = -1;
  int errors = -1;
  double hitsPercent = -1;

  var format = NumberFormat("###.0#", "en_US");

  String question = 'Capital';
  int selectedIndex = 0;

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _openDatabase();
  }

  void _openDatabase() async {
    prefs = await SharedPreferences.getInstance();

    _nextQuestion();

    setState(() {
      attempts = prefs.getInt(ATTEMPTS_KEY) ?? 0;
      hits = prefs.getInt(HITS_KEY) ?? 0;
      errors = prefs.getInt(ERRORS_KEY) ?? 0;
      _calcHitsPercent();
    });
  }

  void _calcHitsPercent(){
    hitsPercent = attempts == 0 ? 0 : (hits * 100) / attempts;
  }

  void _nextQuestion(){
    selectedIndex = _availables[random.nextInt(_availables.length)];
    _availables.removeAt(selectedIndex);
    question = "Capital of ${state[selectedIndex]}";
  }

  void _saveHitsErrors(){
    prefs.setInt(ATTEMPTS_KEY, attempts);
    prefs.setInt(HITS_KEY, hits);
    prefs.setInt(ERRORS_KEY, errors);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Capitals of Brazil"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Attempts: ${attempts >= 0 ? attempts : '-'}"),
            Text("Hits: ${hits >= 0 ? hits : '-'}"),
            Text("Errors: ${errors >= 0 ? errors : '-'}"),
            Text("Hit's Percent: ${attempts >= 0 ? '${format.format(hitsPercent)}%' : '-'}"),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: question,
                ),
              ),
            ),
            ElevatedButton(
                onPressed: attempts >= 0 ? (){
                  attempts++;
                  if (cities[selectedIndex].toLowerCase() == _controller.text.toLowerCase()){
                    hits++;
                  } else {
                    errors++;
                  }

                  _saveHitsErrors();
                  _calcHitsPercent();

                  setState(() {
                    _controller.clear();
                    _nextQuestion();
                  });
                } : null,
                child: const Text("Check"))
          ],
        ),
      ),
    );
  }
}
