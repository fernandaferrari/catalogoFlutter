import 'dart:math';

import 'package:catalogo/app/domain/entities/carrinho.dart';
import 'package:catalogo/app/domain/entities/produto.dart';
import 'package:catalogo/app/infra/repositories_impl/carrinho_repository_impl.dart';
import 'package:flutter/material.dart';

class CarrinhoService with ChangeNotifier {
  CarrinhoRepository repository;

  CarrinhoService(this.repository);

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

  void addItem(Produto produto) {
    if (_items.containsKey(produto.id.toString())) {
      _items.update(
          (produto.id).toString(),
          (existingItem) => CarrinhoItens(
              //para atualizar quando ja existe um item no carrinho
              id: existingItem.id,
              produtoId: existingItem.produtoId,
              name: existingItem.name,
              quantity: existingItem.quantity + 1,
              price: existingItem.price,
              photo: existingItem.photo));
    } else {
      _items.putIfAbsent(
        //Adiciona o primeiro item
        (produto.id).toString(),
        () => CarrinhoItens(
            id: Random().nextInt(1000),
            produtoId: (produto.id!).toInt(),
            name: produto.name!,
            quantity: 1,
            price: produto.price!,
            photo: produto.photo!),
      );
    }
    notifyListeners();
  }

  void removeItem(String produtoId) {
    _items.remove(produtoId);
    notifyListeners();
  }

  void removeSingleItem(String produtoId) {
    if (!_items.containsKey(produtoId)) {
      return;
    }

    if (_items[produtoId]?.quantity == 1) {
      _items.remove(produtoId);
    } else {
      _items.update(
        (produtoId).toString(),
        (existingItem) => CarrinhoItens(
            //para atualizar quando ja existe um item no carrinho
            id: existingItem.id,
            produtoId: existingItem.produtoId,
            name: existingItem.name,
            quantity: existingItem.quantity - 1,
            price: existingItem.price,
            photo: existingItem.photo),
      );
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
