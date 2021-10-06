import 'package:catalogo/app/shared/models/carrinho.dart';

class Pedido {
  final String id;
  final double total;
  final List<Carrinho> produtos;
  final DateTime date;

  Pedido(
      {required this.id,
      required this.total,
      required this.produtos,
      required this.date});
}
