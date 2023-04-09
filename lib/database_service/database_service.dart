import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/responses/shopping_response.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;
  DatabaseService._init();
  String shoppingTable = 'shopping';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('shopping.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE shopping ( 
  id INTEGER PRIMARY KEY AUTOINCREMENT, 
  slug TEXT NOT NULL,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  price INTEGER NOT NULL,
  featured_image TEXT NULL,
  status TEXT NULL,
  created_at TEXT NULL

  )
''');
  }

  Future<String> create(ShoppingData shoppingData) async {
    final db = await instance.database;
    int? count = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM $shoppingTable WHERE id=${shoppingData.id}"));
    if (count! > 0) {
      return "false";
    } else {
      final id = await db.insert(shoppingTable, shoppingData.toJson());
      return "true";
    }
  }

  Future<List<ShoppingData>> readAllTodos() async {
    final db = await instance.database;

    final result = await db.query(shoppingTable);

    return result.map((json) => ShoppingData.fromJson(json)).toList();
  }

  Future<int?> calculate() async {
    final db = await instance.database;

    int? result = Sqflite.firstIntValue(await db.rawQuery("SELECT SUM(price) as Total FROM $shoppingTable"));
    return result;
  }

  Future<int> delete({required int id}) async {
    final db = await instance.database;

    return await db.delete(
      shoppingTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }


}
