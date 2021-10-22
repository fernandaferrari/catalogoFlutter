import 'package:catalogo/app/domain/entities/carrinho.dart';

class Pedido {
  final String id;
  final double total;
  final List<CarrinhoItens> produtos;
  final DateTime date;

  Pedido(
      {required this.id,
      required this.total,
      required this.produtos,
      required this.date});
}
