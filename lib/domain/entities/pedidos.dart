import 'package:catalogo/domain/entities/carrinho.dart';

class Pedido {
  String? id;
  final double total;
  final List<CarrinhoItens> products;
  DateTime? date;

  Pedido({this.id, required this.total, required this.products, this.date});
}
