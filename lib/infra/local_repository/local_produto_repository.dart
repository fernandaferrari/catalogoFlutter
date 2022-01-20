import 'package:catalogo/database/sqlite/connection.dart';
import 'package:catalogo/domain/entities/produto.dart';
import 'package:catalogo/domain/interfaces/repository/produto_repository.dart';

class LocalProdutoRepository implements ProdutoRepository {
  Connection bd;
  LocalProdutoRepository({
    required this.bd,
  });

  @override
  Future<List<Produto>> allProdutos() async {
    List<Map<String, dynamic>> resultado = await bd.queryAllProdutos();
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
    var sql = 'DELETE FROM produto WHERE id=?';
    bd.excluirProduto(sql: sql, id: id);
  }

  @override
  Future<Produto> save({required Produto produto}) async {
    String sql;
    if (produto.id == null) {
      sql =
          'INSERT INTO produto(name, description, photo, price, id_category, isFavorite) VALUES (?,?,?,?,?,?)';
      bd.insertProduto(sql: sql, produto: produto);
    } else {
      sql =
          'UPDATE produto SET name=?, description=?, photo=?, price=?, id_category=?, isFavorite=? WHERE id=?';
      bd.updateProduto(sql: sql, produto: produto);
    }
    List<Map<String, dynamic>> resultado = await bd.ultimoRegistro();

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

    var item = Produto();
    for (var produto in produtos) {
      item = produto;
    }

    return item;
  }

  @override
  toggleFavorite(Produto produto) async {
    try {
      var sql = 'UPDATE produto SET isFavorite=? WHERE id=?';
      bd.updateIsFavorite(sql: sql, produto: produto);
    } catch (error) {
      return error;
    }
  }
}
