import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Class helper untuk mengelola database lokal SQFlite.
class DatabaseHelper {
  static const String _dbName = 'tp_mod_11.db';
  static const String tableName = 'items';

  static Database? _database;

  /// Membuat (atau membuka) database.
  static Future<Database> db() async {
    if (_database != null) return _database!;

    final path = join(await getDatabasesPath(), _dbName);
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database database, int version) async {
        await createTable(database);
      },
    );
    return _database!;
  }

  /// Membuat tabel.
  static Future<void> createTable(Database database) async {
    await database.execute('''
      CREATE TABLE $tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        description TEXT,
        created_at TEXT
      )
    ''');
  }

  /// Menambahkan data ke dalam tabel. Mengembalikan id data baru.
  static Future<int> addItem(String title, String description) async {
    final database = await db();
    final data = {
      'title': title,
      'description': description,
      'created_at': DateTime.now().toIso8601String(),
    };
    return database.insert(
      tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Mengambil seluruh data dari tabel (terbaru di atas).
  static Future<List<Map<String, dynamic>>> readItem() async {
    final database = await db();
    return database.query(tableName, orderBy: 'id DESC');
  }
}