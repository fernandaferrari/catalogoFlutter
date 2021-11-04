import 'dart:math';

import 'package:catalogo/app/domain/entities/carrinho.dart';
import 'package:catalogo/app/domain/entities/produto.dart';
import 'package:catalogo/app/infra/repositories_impl/carrinho_repository_impl.dart';
import 'package:flutter/material.dart';

class CarrinhoService with ChangeNotifier {
  Map<String, CarrinhoItens> _items = {};

  Map<String, CarrinhoItens> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });

    return total;
  }

  void addItem(Produto product) {
    if (_items.containsKey(product.id)) {
      _items.update(
          product.id.toString(),
          (existingItem) => CarrinhoItens(
                //para atualizar quando ja existe um item no carrinho
                id: existingItem.id,
                productId: existingItem.productId,
                title: existingItem.title,
                quantity: existingItem.quantity + 1,
                price: existingItem.price,
              ));
    } else {
      _items.putIfAbsent(
        //Adiciona o primeiro item
        product.id.toString(),
        () => CarrinhoItens(
          id: Random().nextDouble().toString(),
          productId: product.id.toString(),
          title: product.name.toString(),
          quantity: 1,
          price: product.price!.toDouble(),
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }

    if (_items[productId]?.quantity == 1) {
      _items.remove(productId);
    } else {
      _items.update(
        productId,
        (existingItem) => CarrinhoItens(
          //para atualizar quando ja existe um item no carrinho
          id: existingItem.id,
          productId: existingItem.productId,
          title: existingItem.title,
          quantity: existingItem.quantity - 1,
          price: existingItem.price,
        ),
      );
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
