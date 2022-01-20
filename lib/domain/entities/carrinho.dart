import 'package:catalogo/domain/entities/produto.dart';

class CarrinhoItens {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;
  DateTime? date;
  List<Produto>? produtos;

  CarrinhoItens({
    required this.id,
    required this.productId,
    required this.title,
    required this.quantity,
    required this.price,
    this.date,
    this.produtos,
  });
}
