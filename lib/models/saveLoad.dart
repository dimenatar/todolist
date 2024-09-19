import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'lab2.dart';

abstract class SaveLoad
{
  Future<List<Quote>> load();
  void save(List<Quote> quotes);
}

class NewFileIO implements SaveLoad {
  static const String fileName = 'quotes.json';

  @override
  Future<List<Quote>> load() async {
    try
    {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$fileName');
      if (await file.exists())
      {
        final content = await file.readAsString();
        if (content.isNotEmpty) {
        return List<Quote>.from(jsonDecode(content).map((model) => Quote.fromJson(model)));
        }
      }
    } catch (e) {
    print('Error loading quotes from file: $e');
    }
    return List<Quote>.empty();
  }

  @override
  void save(List<Quote> quotes) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$fileName');
      final jsonData = jsonEncode(quotes);

    await file.writeAsString(jsonData);
    } catch (e) {
    print('Error saving quotes to file: $e');
    }
  }
}

class PreferencesIO implements SaveLoad{

  static const String name = 'quotes';
  late SharedPreferences prefs;

  @override
  Future<List<Quote>> load() async{
    prefs = await SharedPreferences.getInstance();
    String jsonData = (prefs.getString(name) ?? "");
    if (jsonData != "")
      {

        Iterable l = json.decode(jsonData);
        return List<Quote>.from(l.map((model) => Quote.fromJson(model)));
      }
    return List<Quote>.empty();
  }

  @override
  void save(List<Quote> quotes) async {
    String jsonData = jsonEncode(quotes);
    prefs = await SharedPreferences.getInstance();
    prefs.setString(name, jsonData);
  }

}

class SqliteIO implements SaveLoad {
  static const String dbName = 'quotesdb.db';
  static const String tableQuotes = 'quotes';
  static const String colId = 'id';
  static const String content = 'content';
  static const String chapter = 'chapter';
  static const String verse = 'verse';

  Database? _db;

  @override
  Future<List<Quote>> load() async {
    await _initDb();
    final List<Map<String, dynamic>> maps = await _db!.query(tableQuotes);
    return List<Quote>.from(maps.map((map) => Quote.fromJson(map)));
  }

  @override
  void save(List<Quote> quotes) async {
    await _initDb();
    quotes.forEach((quote) async {
      await _db!.insert(tableQuotes, quote.toJson());
    });
  }

  Future<void> _initDb() async {
    if (_db == null) {
      final databasesPath = await getDatabasesPath();
      final path = '$databasesPath/$dbName';
      _db = await openDatabase(path,
          version: 1,
          onCreate: (db, version) {
            db.execute('''
              CREATE TABLE $tableQuotes (
                $colId INTEGER PRIMARY KEY AUTOINCREMENT,
                $content TEXT NOT NULL,
                $chapter INT,
                $verse INT
              )
            ''');
          });
/*      await _db?.execute('DROP DATABASE IF EXISTS $dbName');
      await _db!.execute('CREATE DATABASE $dbName');
      await _db!.execute('USE $dbName');
      await _db!.execute('''
              CREATE TABLE $tableQuotes (
                $colId INTEGER PRIMARY KEY AUTOINCREMENT,
                $content TEXT NOT NULL,
                $chapter INT,
                $verse INT
              )
            ''');*/

    }
  }
}