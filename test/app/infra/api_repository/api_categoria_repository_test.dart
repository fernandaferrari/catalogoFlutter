import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

import 'package:catalogo/app/domain/entities/categoria.dart';
import 'package:catalogo/app/infra/api_repository/api_categoria_repository.dart';

class ApiCategoriaRepositoryMock extends Mock
    implements IApiCategoriaRepository {
  final Client client;

  ApiCategoriaRepositoryMock(this.client);

  @override
  Future<List<Categoria>> AllCategoria() async {
    List<Categoria> _items = [];
    final response =
        await client.get(Uri.parse('https://pastebin.com/raw/nE1gbL9r'));
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

void main() {
  test('api categoria repository ...', () async {
    final client = Client();
    final repository = ApiCategoriaRepositoryMock(client);

    final list = await repository.AllCategoria();
    expect(list.isNotEmpty, equals(true));
  });
}
