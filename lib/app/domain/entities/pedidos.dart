import 'package:catalogo/app/domain/entities/carrinho.dart';

class Pedido {
  int? id;
  double? total;
  DateTime? date;
  int? id_carrinho;
  List<CarrinhoItens>? produtos = [];

  Pedido({
    this.id,
    this.total,
    this.date,
    this.id_carrinho,
    this.produtos,
  });
}
