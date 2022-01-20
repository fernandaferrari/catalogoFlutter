import 'package:catalogo/domain/interfaces/services/carrinho_service.dart';
import 'package:catalogo/domain/interfaces/services/pedido_service.dart';
import 'package:mobx/mobx.dart';

import 'package:catalogo/domain/entities/carrinho.dart';
import 'package:catalogo/domain/entities/pedidos.dart';
import 'package:catalogo/domain/entities/produto.dart';

part 'carrinho_controller.g.dart';

class CarrinhoController = _CarrinhoControllerBase with _$CarrinhoController;

abstract class _CarrinhoControllerBase with Store {
  ICarrinhoService service;
  IPedidoService pedidoService;

  _CarrinhoControllerBase({
    required this.service,
    required this.pedidoService,
  }) {
    _init();
  }

  @observable
  List<CarrinhoItens>? carrinho;

  @observable
  List<CarrinhoItens>? pedido;

  @observable
  double? total = 0;

  @action
  _init() async {
    carrinho = service.items.values.toList();
    totalAmount();
  }

  @action
  void criarPedido(List<CarrinhoItens> cart, double total) {
    if (cart.isNotEmpty) {
      var item = Pedido(total: total, products: cart);
      pedidoService.addPedido(pedido: item);
    } else {
      throw 'Sem itens no carrinho';
    }
  }

  @action
  void totalAmount() {
    total = service.totalAmount;
  }

  @action
  void removeCarrinho(productId) {
    service.removeItem(productId);
    carrinho = service.items.values.toList();
    totalAmount();
  }

  @action
  void itensClear() {
    service.clear();
    carrinho = service.items.values.toList();
    totalAmount();
  }

  @action
  void addItem(Produto produto) {
    service.addItem(produto);
    carrinho = service.items.values.toList();
  }

  @action
  void removeUmItem(id) {
    service.removeSingleItem(id);
    carrinho = service.items.values.toList();
  }
}
