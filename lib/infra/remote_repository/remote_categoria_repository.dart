import 'dart:convert';

import 'package:catalogo/domain/entities/categoria.dart';
import 'package:catalogo/domain/interfaces/repository/categoria_repository.dart';
import 'package:http/http.dart';

class RemoteCategoriaRepository implements CategoriaRepository {
  Client client;

  RemoteCategoriaRepository({required this.client});

  @override
  Future<List<Categoria>> allCategoria() async {
    List<Categoria> _items = [];
    final response =
        await client.get(Uri.parse('https://pastebin.com/raw/nE1gbL9r'));
    try {
      List<dynamic> data = jsonDecode(response.body);
      for (var productData in data) {
        _items.add(Categoria(
          id: productData['id'],
          name: productData['name'],
        ));
      }
    } catch (e) {
      return throw ('Erro na resquisição da lista');
    }
    return _items;
  }
}
