import 'package:shop_now/model/cart_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlService {
  static final SqlService instance = SqlService._internal();
  static Database? _database;

  SqlService._internal();

  static const String databaseName = 'shop_now.db';

  static const int versionNumber = 1;


  static const String tableNotes = 'cart';



  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();

    return _database!;
  }

  _initDatabase() async {
    var databasesPath = await getDatabasesPath();

    String path = join(databasesPath, databaseName);
    // When the database is first created, create a table to store Notes.
    var db =
    await openDatabase(path, version: versionNumber, onCreate: _onCreate);
    return db;
  }

  // Run the CREATE TABLE statement on the database.
  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE IF NOT EXISTS $tableNotes ("
        "id INTEGER PRIMARY KEY,"
        "quantity INTEGER,"
        "title TEXT,"
        "image Text,"
        "totalPrice REAL,"
        "category TEXT,"
        "price REAL)");
  }

  Future<List<CartModel>> getAll() async {
    final db = await database;

    final result = await db.query(tableNotes);

    return result.map((json) => CartModel.fromJson(json)).toList();
  }

  Future<CartModel> read(int id) async {
    final db = await database;
    final maps = await db.query(
      tableNotes,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return CartModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<void> insert(CartModel note) async {
    final db = await database;

    await db.insert(tableNotes, note.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }


  Future<int> update(CartModel note) async {
    final db = await database;
    var res = await db.update(tableNotes, note.toJson(),
        where: 'id = ?',
        whereArgs: [note.id]);
    return res;
  }

  Future<void> delete(int id) async {
    final db = await database;
    try {
      await db.delete(tableNotes,
          where: "id = ?",
          whereArgs: [id]);
    } catch (err) {
      print("Something went wrong when deleting an item: $err");
    }
  }

  Future close() async {
    final db = await database;
    db.close();
  }

  deleteAll() async {
    final db = await database;
     await db.rawDelete("DELETE FROM  $tableNotes");
  }
}
