import 'dart:convert';

import 'package:catalogo/domain/interfaces/repository/pedido_repository.dart';
import 'package:http/http.dart';

import 'package:catalogo/domain/entities/carrinho.dart';
import 'package:catalogo/domain/entities/pedidos.dart';
import 'package:catalogo/infra/utils/constants.dart';

class RemotePedidoRepository implements PedidoRepository {
  Client client;
  RemotePedidoRepository({
    required this.client,
  });

  @override
  Future<List<Pedido>> allPedidos() async {
    final List<Pedido> _items = [];
    final response = await client.get(
      Uri.parse('${Constants.pedidoUrl}.json'),
    );
    if (response.body == 'null') return _items;
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((orderId, orderData) {
      _items.add(Pedido(
          id: orderId,
          total: orderData['total'],
          date: DateTime.parse(orderData['date']),
          products: (orderData['products'] as List<dynamic>).map((item) {
            return CarrinhoItens(
              id: item['id'],
              productId: item['productId'],
              title: item['title'],
              quantity: item['quantity'],
              price: item['price'],
            );
          }).toList()));
    });
    return _items;
  }

  @override
  savePedido({required Pedido pedido}) async {
    final List<Pedido> _items = [];
    final date = DateTime.now();
    final response = await client.post(
      Uri.parse('${Constants.pedidoUrl}.json'),
      body: jsonEncode(
        {
          'total': pedido.total,
          'date': date.toIso8601String(),
          'products': pedido.products
              .map((cartItem) => {
                    'id': cartItem.id,
                    'productId': cartItem.productId,
                    'title': cartItem.title,
                    'quantity': cartItem.quantity,
                    'price': cartItem.price
                  })
              .toList(),
        },
      ),
    );

    final id = jsonDecode(response.body)['name'];
    _items.insert(
      0,
      Pedido(
        id: id,
        total: pedido.total,
        date: date,
        products: pedido.products,
      ),
    );
  }
}
