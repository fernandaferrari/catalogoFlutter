import 'dart:convert';

import 'package:catalogo/app/domain/entities/produto.dart';
import 'package:catalogo/app/domain/interfaces/produto_repository.dart';
import 'package:catalogo/app/infra/api_repository/api_produto_repository.dart';
import 'package:catalogo/app/infra/database/sqlite/connection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

class ApiProdutoRepositoryMock extends Mock implements IApiProdutoRepository {
  Client client;
  ApiProdutoRepositoryMock(this.client);

  @override
  Future<List<Produto>> AllProdutos() async {
    List<Produto> _items = [];
    final response =
        await client.get(Uri.parse('https://pastebin.com/raw/8t83iHMc'));
    try {
      List<dynamic> data = jsonDecode(response.body);
      data.forEach((productData) {
        _items.add(
          Produto(
            id: productData['id'],
            name: productData['name'],
            description: productData['description'],
            price: productData['price'],
            photo: productData['photo']!,
            categoryId: productData['category_id'],
            //isFavorite: productData['isFavorite'],
          ),
        );
      });
    } catch (e) {
      return throw ('Erro na resquisição da lista');
    }
    return _items;
  }
}

class ProdutoRepositoryMock extends Mock implements IProdutoRepository {
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
          categoryId: item['category_id'],
          isFavorite: item['isFavorite']);
    });

    return produtos;
  }

  @override
  remove(int id) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  save(Produto produto) {
    // TODO: implement save
    throw UnimplementedError();
  }
}

void main() {
  test('Lista de produtos ...', () async {
    //final repository = ProdutoRepositoryMock();
    final client = Client();
    final repository = ApiProdutoRepositoryMock(client);
    final list = await repository.AllProdutos();

    expect(list.isNotEmpty, equals(true));
  });
}
