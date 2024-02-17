import 'dart:math';

import 'package:flutter/material.dart';
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

    //_nextQuestion();

    setState(() {
      attempts = prefs.getInt(ATTEMPTS_KEY) ?? 0;
      hits = prefs.getInt(HITS_KEY) ?? 0;
      errors = prefs.getInt(ERRORS_KEY) ?? 0;
      //_calcHitsPercent();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
