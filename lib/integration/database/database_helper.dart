import 'dart:async';
import 'package:dict_daily/domain/widgets/dict_word_widget.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;
  // where the singleton is made
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static const String wordTable = 'words';
  static const String favouritesTable = 'favs';

  DatabaseHelper._privateConstructor();

  // Singleton Database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'words.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    // TODO verify this works!
    await db.execute('''
          CREATE TABLE $wordTable(id INTEGER PRIMARY KEY, name TEXT, pronounciation TEXT, descriptions INTEGER);
          CREATE TABLE $favouritesTable(id INTEGER PRIMARY KEY, word_id INTEGER, FOREIGN KEY (word_id) REFERENCES words(id) ON DELETE CASCADE);
    ''');
    version = 1;
  }

  Future<List<Map<String, Object?>>> wordGet(int queryIndex) async {
    Database db = await instance.database;
    return await db.query(wordTable, where: 'id == ?', whereArgs: [queryIndex]);
  }

  Future<int> wordInsert(DictWord dictWord) async {
    Database db = await instance.database;
    return await db.insert(wordTable, dictWord.toMap());
  }

  Future<bool> favouriteContains(DictWord wordToCheck) async {
    Database db = await instance.database;
    var wordID = wordToCheck.id;
    return db
        .rawQuery('SELECT id from $favouritesTable where word_id = $wordID')
        .then((value) => value.isNotEmpty);
  }

  Future<int> favouriteInsert(DictWord dictWord) async {
    Database db = await instance.database;
    return await db.insert(favouritesTable, dictWord.toMap());
  }

  Future<int?> favouriteRemove(DictWord dictWord) async {
    var db = await instance.database;
    return await db.delete(favouritesTable,
        where: 'word_id = ?', whereArgs: [dictWord.id]);
  }

  Future<List<Map<String, dynamic>>> favouritesGetAll() {
    return queryAllRows(favouritesTable);
  }

  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> queryTopRow(String table) async {
    var db = await instance.database;

    return db.query(table, limit: 1);
  }

  Future<int?> queryCountWords() async {
    var db = await instance.database;
    var res = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $wordTable'));

    return res;
  }
}
