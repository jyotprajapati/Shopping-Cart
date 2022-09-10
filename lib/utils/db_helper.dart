import 'package:learningapp/models/productModels.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "shopping.db";
  static final _databaseVersion = 1;

  static final table = 'cart';

  static final columnId = 'id';
  static final columnName = 'title';
  static final columnAmt = 'price';
  static final columnImage = 'featuredImage';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT ,
            $columnAmt INTEGER,
            $columnImage TEXT
          )
          ''');
  }

  Future<int> insert(Products product, int quantity) async {
    Database? db = await instance.database;
    return await db!.insert(table, {
      'id': product.id,
      'title': product.title,
      'price': product.price,
      'featuredImage': product.featuredImage
    });
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await instance.database;
    return await db!.query(table);
  }

  clearDB() async {
    Database? db = await instance.database;
    await db!.delete(table);
  }
}
