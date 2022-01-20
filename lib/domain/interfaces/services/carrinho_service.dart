import 'package:catalogo/domain/entities/carrinho.dart';
import 'package:catalogo/domain/entities/produto.dart';

abstract class ICarrinhoService {
  Map<String, CarrinhoItens> get items;
  double get totalAmount;
  void addItem(Produto product);
  void removeItem(String productId);
  void removeSingleItem(String productId);
  void clear();
}
