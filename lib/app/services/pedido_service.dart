import 'dart:convert';
import 'package:catalogo/app/domain/entities/carrinho.dart';
import 'package:catalogo/app/domain/entities/pedidos.dart';
import 'package:catalogo/app/infra/utils/constants.dart';
import 'package:catalogo/app/services/carrinho_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PedidoService with ChangeNotifier {
  PedidoService();

  List<Pedido> _items = [];

  List<Pedido> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Future addPedido(CarrinhoService cart) async {
    final date = DateTime.now();
    final response = await http.post(
      Uri.parse('${Constants.PEDIDO_BASE_URL}.json'),
      body: jsonEncode(
        {
          'total': cart.totalAmount,
          'date': date.toIso8601String(),
          'products': cart.items.values
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
        total: cart.totalAmount,
        date: date,
        products: cart.items.values.toList(),
      ),
    );
    notifyListeners();
  }

  Future loadPedidos() async {
    _items.clear();
    final response = await http.get(
      Uri.parse('${Constants.PEDIDO_BASE_URL}.json'),
    );
    if (response.body == 'null') return;
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
    return items;
  }
}
