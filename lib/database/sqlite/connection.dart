import 'package:catalogo/domain/entities/categoria.dart';
import 'package:catalogo/infra/remote_repository/remote_categoria_repository.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:catalogo/domain/entities/produto.dart';
import 'package:catalogo/infra/remote_repository/remote_produto_repository.dart';

class Connection {
  final categoria = RemoteCategoriaRepository(client: Client());
  final produto = RemoteProdutoRepository(Client());

  static final Connection instance = Connection._();

  Connection._();

  static Database? _database;

  get database async {
    if (_database != null) return _database;

    return await _initDatabase();
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), 'catalogo');
    return _database = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(db, version) async {
    await db.execute(_categoria);
    await db.execute(_produto);
    await setCategoria(db);
    await setupProdutos(db);
  }

  setCategoria(db) async {
    var _item = await categoria.allCategoria();
    for (Categoria categoria in _item) {
      db.insert('categoria', {'id': categoria.id, 'name': categoria.name});
    }
  }

  setupProdutos(db) async {
    var _item = await produto.allProdutos();
    for (Produto produto in _item) {
      db.insert('produto', {
        'id': produto.id,
        'name': produto.name,
        'description': produto.description,
        'photo': produto.photo,
        'price': produto.price,
        'id_category': produto.categoryId,
        'isFavorite': produto.isFavorite
      });
    }
  }

  queryAllProdutos() async {
    var bd = await database;
    return await bd.query('produto');
  }

  ultimoRegistro() async {
    var bd = await database;
    return await bd.rawQuery(
        'SELECT * FROM produto WHERE id=(SELECT max(id) FROM produto)');
  }

  insertProduto({required String sql, required produto}) async {
    var bd = await database;
    bd.rawInsert(sql, [
      produto.name,
      produto.description,
      produto.photo,
      produto.price,
      produto.categoryId,
      produto.isFavorite,
    ]);
  }

  updateProduto({required String sql, required produto}) async {
    var bd = await database;
    bd.rawUpdate(sql, [
      produto.name,
      produto.description,
      produto.photo,
      produto.price,
      produto.categoryId,
      produto.isFavorite,
      produto.id,
    ]);
  }

  updateIsFavorite({required String sql, required produto}) async {
    var bd = await database;
    bd.rawUpdate(sql, [
      produto.isFavorite,
      produto.id,
    ]);
  }

  excluirProduto({required String sql, required int id}) async {
    var bd = await database;
    bd.rawDelete(sql, [id]);
  }

  String get _produto => '''
  CREATE TABLE produto(
    id INTEGER PRIMARY KEY,
    name TEXT,
    description TEXT,
    photo TEXT,
    price REAL,
    isFavorite INTEGER,
    id_category INTEGER,
    FOREIGN KEY(id_category) REFERENCES categoria(id) ON DELETE CASCADE
  );
  ''';

  String get _categoria => '''
  CREATE TABLE categoria(
    id INTEGER PRIMARY KEY,
    name TEXT
  );
  ''';
}
