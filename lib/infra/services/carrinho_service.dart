import 'dart:math';

import 'package:catalogo/domain/entities/carrinho.dart';
import 'package:catalogo/domain/entities/produto.dart';
import 'package:catalogo/domain/interfaces/services/carrinho_service.dart';

class CarrinhoService implements ICarrinhoService {
  Map<String, CarrinhoItens> _items = {};

  @override
  Map<String, CarrinhoItens> get items {
    return {..._items};
  }

  @override
  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });

    return total;
  }

  @override
  void addItem(Produto product) {
    if (_items.containsKey(product.id.toString())) {
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
  }

  @override
  void removeItem(String productId) {
    _items.remove(productId);
  }

  @override
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
  }

  @override
  void clear() {
    _items = {};
  }
}
