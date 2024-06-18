import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  Future<Database> initialDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'project.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 6, onUpgrade: _onUpgrade);
    return mydb;
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print("onUpgrade =====================================");
    if (oldVersion < 6) {
      // Check if the table 'words' exists
      List<Map<String, dynamic>> tables = await db.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name='words'");
      if (tables.isEmpty) {
        // If 'words' table does not exist, create it
        await _createWordsTable(db);
      } else {
        // If 'words' table exists, alter it to add the 'image' column
        await db.execute('ALTER TABLE words ADD COLUMN image BLOB');
        print("Column 'image' added =====================================");
      }
    }
  }

  void _onCreate(Database db, int version) async {
    await _createWordsTable(db);
    print("onCreate =====================================");
  }

  Future<void> _createWordsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS words (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        english TEXT,
        turkey TEXT,
        image BLOB
      )
    ''');
  }

  Future<int> insertData(String english, String turkey, List<int> image) async {
    Database? mydb = await db;
    int response = await mydb!.insert(
        'words', {'english': english, 'turkey': turkey, 'image': image});
    return response;
  }

  Future<List<Map<String, dynamic>>> readData(String sql) async {
    Database? mydb = await db;
    List<Map<String, dynamic>> response = await mydb!.rawQuery(sql);
    return response;
  }

  Future<int> updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  Future<int> deleteData(String sql, List<dynamic> params) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql, params);
    return response;
  }
}
