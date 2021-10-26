import 'dart:convert';

import 'package:catalogo/app/domain/entities/produto.dart';
import 'package:http/http.dart';

class ApiProdutoRepository {
  Client client;

  ApiProdutoRepository(this.client);

  Future<List<Produto>> AllProdutos() async {
    List<Produto> _items = [];
    final response =
        await client.get(Uri.parse('https://pastebin.com/raw/8t83iHMc'));
    try {
      List<dynamic> data = jsonDecode(response.body);
      data.forEach((productData) {
        _items.add(Produto(
          id: productData['id'],
          name: productData['name'],
          description: productData['description'],
          price: productData['price'],
          photo: productData['photo'],
          categoryId: productData['category_id'],
        ));
      });
    } catch (e) {
      return throw ('Erro na resquisição da lista');
    }
    return _items;
  }
}
