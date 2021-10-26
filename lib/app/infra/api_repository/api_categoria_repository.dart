import 'dart:convert';

import 'package:catalogo/app/domain/entities/categoria.dart';
import 'package:catalogo/app/infra/utils/json/constants.dart';
import 'package:http/http.dart';

class ApiCategoriaRepository {
  Client client;

  ApiCategoriaRepository(this.client);

  Future<List<Categoria>> AllCategoria() async {
    List<Categoria> _items = [];
    final response = await client.get(Uri.parse('${Constants.BASE_CATEGORIA}'));
    try {
      List<dynamic> data = jsonDecode(response.body);
      data.forEach((productData) {
        _items.add(Categoria(
          id: productData['id'],
          name: productData['name'],
        ));
      });
    } catch (e) {
      return throw ('Erro na resquisição da lista');
    }
    return _items;
  }
}
