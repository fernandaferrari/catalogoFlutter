import 'dart:convert';

import 'package:catalogo/app/domain/entities/categoria.dart';
import 'package:catalogo/app/domain/interfaces/categoria_repository.dart';
import 'package:catalogo/app/infra/database/sqlite/connection.dart';
import 'package:catalogo/app/utils/json/constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;

class CategoriaRepositoryImpl implements ICategoriaRepository {
  @override
  Future<List<Categoria>> AllCategorias() async {
    List<Categoria> _items = [];
    try {
      final response = await http.get(
        Uri.parse('${Constants.CATEGORIA_BASE_URL}.json'),
      );
      List<dynamic> data = jsonDecode(response.body);
      data.forEach((categoriaData) {
        _items.add(
          Categoria(
            id: categoriaData['id'],
            name: categoriaData['name'],
          ),
        );
      });
    } catch (e) {
      return throw ('Erro na leitura das categorias');
    }
    return _items;
  }
}

  // @override
  // Future<List<Categoria>> fetchCategoria() async {
  //   _db = await Connection.instance.database;
  //   List<Map<String, dynamic>> resultado = await _db.query('categoria');
  //   List<Categoria> categoria = List.generate(resultado.length, (index) {
  //     var item = resultado[index];
  //     return Categoria(id: item['id'], name: item['name']);
  //   });

  //   return categoria;
  // }