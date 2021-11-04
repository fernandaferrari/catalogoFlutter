import 'package:catalogo/app/domain/entities/categoria.dart';
import 'package:catalogo/app/infra/api_repository/api_categoria_repository.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:catalogo/app/domain/entities/produto.dart';
import 'package:catalogo/app/infra/api_repository/api_produto_repository.dart';

class Connection {
  ApiCategoriaRepository cat;
  ApiProdutoRepository repository;

  Connection(this.repository, this.cat);

  static final Connection instance = Connection(
      ApiProdutoRepository(Client()), ApiCategoriaRepository(Client()));

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
    await db.execute(categoria);
    await db.execute(produto);
    await setCategoria(db);
    await setupProdutos(db);
  }

  setCategoria(db) async {
    var _item = await cat.AllCategoria();
    for (Categoria categoria in _item) {
      db.insert('categoria', {'id': categoria.id, 'name': categoria.name});
    }
  }

  setupProdutos(db) async {
    var _item = await repository.AllProdutos();
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

  String get produto => '''
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

  String get categoria => '''
  CREATE TABLE categoria(
    id INTEGER PRIMARY KEY,
    name TEXT
  );
  ''';
}
