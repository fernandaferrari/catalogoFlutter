import 'dart:convert';

import 'package:catalogo/app/dominio/models/produto.dart';
import 'package:catalogo/app/shared/utils/constants.dart';
import 'package:http/http.dart' as http;

class ProdutoRepository {
  Future<List<Produto>> fetchProdutos() async {
    List<Produto> _items = [];
    try {
      final response = await http.get(
        Uri.parse('${URL_BASE}.json'),
      );
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
            isFavorite: productData['isFavorite'],
          ),
        );
      });
    } catch (e) {
      return throw ('Erro na resquisição da lista');
    }
    return _items;
  }
}
