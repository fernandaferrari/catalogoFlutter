import 'dart:convert';
import 'package:catalogo/app/domain/entities/carrinho.dart';
import 'package:catalogo/app/domain/entities/pedidos.dart';
import 'package:catalogo/app/infra/repositories_impl/pedido_repository_impl.dart';
import 'package:catalogo/app/services/carrinho_service.dart';
import 'package:catalogo/app/utils/json/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PedidoService with ChangeNotifier {
  PedidoRepositoryImpl repository;

  PedidoService(this.repository);

  List<Pedido> _items = [];

  List<Pedido> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Future addPedido(cart) async {
    await repository.save(cart);
  }

  // Future addPedido(cart) async {
  //   final date = DateTime.now();
  //   final response = await http.post(
  //     Uri.parse('${Constants.PEDIDO_BASE_URL}.json'),
  //     body: jsonEncode(
  //       {
  //         'total': cart.totalAmount,
  //         'date': date.toIso8601String(),
  //         'products': cart.items.values
  //             .map((cartItem) => {
  //                   'id': cartItem.id,
  //                   'productId': cartItem.produtoId,
  //                   'title': cartItem.name,
  //                   'quantity': cartItem.quantity,
  //                   'price': cartItem.price,
  //                   'photo': cartItem.photo
  //                 })
  //             .toList(),
  //       },
  //     ),
  //   );

  //   final id = jsonDecode(response.body)['name'];
  //   _items.insert(
  //     0,
  //     Pedido(
  //       id: id,
  //       total: cart.totalAmount,
  //       date: DateTime.now(),
  //       id_carrinho: cart.id,
  //       produtos: cart.items.values.toList(),
  //     ),
  //   );
  //   notifyListeners();
  // }

  Future loadPedidos() async {
    _items = await repository.AllPedidos();
    notifyListeners();
  }
}
