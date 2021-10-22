import 'dart:convert';

import 'package:catalogo/app/domain/entities/carrinho.dart';
import 'package:catalogo/app/domain/entities/pedidos.dart';
import 'package:catalogo/app/domain/interfaces/pedido_repository.dart';
import 'package:catalogo/app/infra/database/sqlite/connection.dart';
import 'package:catalogo/app/utils/json/constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;

class PedidoRepositoryImpl implements IPedidoRepository {
  @override
  Future<List<Pedido>> AllPedidos() async {
    List<Pedido> _items = [];
    try {
      final response =
          await http.get(Uri.parse('${Constants.PEDIDO_BASE_URL}.json'));
      Map<String, dynamic> data = jsonDecode(response.body);

      data.forEach((orderId, orderData) {
        _items.add(Pedido(
            id: orderId,
            total: orderData['total'],
            date: DateTime.parse(orderData['date']),
            produtos: (orderData['products'] as List<dynamic>).map((item) {
              return CarrinhoItens(
                  id: item['id'],
                  produtoId: item['productId'],
                  name: item['title'],
                  quantity: item['quantity'],
                  price: item['price'],
                  photo: item['photo']!);
            }).toList()));
      });
    } catch (e) {
      return throw ('Erro na resquisição da lista de pedidos');
    }
    return _items;
  }

  @override
  save(Pedido pedido) {
    // TODO: implement save
    throw UnimplementedError();
  }
}

  // late Database _db;

  // @override
  // Future<List<PedidoEntity>> AllPedidos() async {
  //   _db = await Connection.instance.database;
  //   List<Map<String, dynamic>> resultado = await _db.query('pedido');
  //   List<PedidoEntity> pedido = List.generate(resultado.length, (index) {
  //     var item = resultado[index];
  //     return PedidoEntity(
  //       id: item['id'],
  //       total: item['total'],
  //       date: item['date'],
  //       id_carrinho: item['id_carrinho'],
  //     );
  //   });
  //   return pedido;
  // }

  // @override
  // save(PedidoEntity pedido) async {
  //   _db = await Connection.instance.database;
  //   var sql = 'INSERT INTO pedido(total, id_carrinho, date) VALUES (?,?,?)';
  //   _db.rawInsert(sql, [pedido.total, pedido.id_carrinho, pedido.date]);
  // }