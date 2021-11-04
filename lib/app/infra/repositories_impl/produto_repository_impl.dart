import 'package:catalogo/app/infra/database/sqlite/connection.dart';

import 'package:catalogo/app/domain/entities/produto.dart';
import 'package:catalogo/app/domain/interfaces/produto_repository.dart';

class ProdutoRepositoryImpl implements IProdutoRepository {
  List<Produto> _items = [];

  ProdutoRepositoryImpl() {
    AllProdutos();
  }

  @override
  Future<List<Produto>> AllProdutos() async {
    var _db = await Connection.instance.database;
    List<Map<String, dynamic>> resultado = await _db.query('produto');
    List<Produto> produtos = List.generate(resultado.length, (index) {
      var item = resultado[index];
      return Produto(
          id: item['id'],
          name: item['name'],
          description: item['description'],
          photo: item['photo'],
          price: item['price'],
          categoryId: item['id_category'],
          isFavorite: item['isFavorite']);
    });

    return produtos;
  }

  @override
  remove(int id) async {
    var _db = await Connection.instance.database;
    var sql = 'DELETE FROM produto WHERE id=?';
    _db.rawDelete(sql, [id]);
  }

  @override
  save(Produto produto) async {
    var _db = await Connection.instance.database;
    var sql;
    if (produto.id == null) {
      sql =
          'INSERT INTO produto(name, description, photo, price, id_category, isFavorite) VALUES (?,?,?,?,?,?)';
      _db.rawInsert(sql, [
        produto.name,
        produto.description,
        produto.photo,
        produto.price,
        produto.categoryId,
        produto.isFavorite,
      ]);
    } else {
      sql =
          'UPDATE produto SET name=?, description=?, photo=?, price=?, id_category=?, isFavorite=? WHERE id=?';
      _db.rawUpdate(sql, [
        produto.name,
        produto.description,
        produto.photo,
        produto.price,
        produto.categoryId,
        produto.isFavorite,
        produto.id,
      ]);
    }
  }

  toggleFavorite(Produto produto) async {
    try {
      var _db = await Connection.instance.database;
      var sql = 'UPDATE produto SET isFavorite=? WHERE id=?';
      _db.rawUpdate(sql, [
        produto.isFavorite,
        produto.id,
      ]);
    } catch (error) {
      return error;
    }
  }
}
