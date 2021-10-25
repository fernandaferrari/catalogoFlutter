import 'package:catalogo/app/domain/entities/carrinho.dart';
import 'package:catalogo/app/domain/entities/pedidos.dart';
import 'package:catalogo/app/domain/interfaces/pedido_repository.dart';
import 'package:catalogo/app/infra/database/sqlite/connection.dart';

class PedidoRepositoryImpl implements IPedidoRepository {
  @override
  Future<List<Pedido>> AllPedidos() async {
    var _db = await Connection.instance.database;
    List<Map<String, dynamic>> resultado = await _db.query('pedido');
    List<Pedido> pedidos = List.generate(resultado.length, (index) {
      var item = resultado[index];
      return Pedido(
          id: item['id'],
          total: item['total'],
          date: DateTime.parse(item['date']),
          id_carrinho: item['id'],
          produtos: (item['products'] as List<dynamic>).map((item) {
            return CarrinhoItens(
                id: item['id'],
                produtoId: item['productId'],
                name: item['title'],
                quantity: item['quantity'],
                price: item['price'],
                photo: item['photo']!);
          }).toList());
    });

    return pedidos;
  }

  @override
  save(Pedido pedido) async {
    var _db = await Connection.instance.database;
    var sql = 'INSERT INTO pedido(total, id_carrinho, date) VALUES (?,?,?)';
    _db.rawInsert(sql, [pedido.total, pedido.produtos, pedido.date]);
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