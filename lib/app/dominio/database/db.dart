import 'package:catalogo/app/dominio/database/script_database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  DB._();

  static final DB instance = DB._();

  late ScriptDatabase script;

  static Database? _database;

  get database async {
    if (_database != null) return _database;

    return await _initDatabase();
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), 'loja.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(db, version) async {
    await db.execute(script.produto);
    await db.execute(script.categoria);
    await db.execute(script.carrinho);
    await db.execute(script.pedido);
    await db.execute(script.login);
  }
}
