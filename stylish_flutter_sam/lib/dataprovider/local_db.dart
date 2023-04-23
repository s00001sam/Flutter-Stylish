import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDB {
  static const String DB_NAME = 'sam_stylish.sqlite';
  static final LocalDB _instance = LocalDB._internal();

  Database? _db;

  LocalDB._internal();

  factory LocalDB() {
    return _instance;
  }

  Future<Database> getDB() async {
    final dbPath = await getDatabasesPath();
    return _db ??= await openDatabase(
      join(dbPath, DB_NAME),
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE cart(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          productId TEXT, 
          imageUrl TEXT, 
          name TEXT, 
          colorCode TEXT, 
          size TEXT, 
          count INTEGER, 
          prize INTEGER)
          ''',
        );
      },
      version: 1,
    );
  }
}
