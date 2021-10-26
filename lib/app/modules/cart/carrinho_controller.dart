import 'package:catalogo/app/domain/entities/pedidos.dart';
import 'package:catalogo/app/services/pedido_service.dart';
import 'package:mobx/mobx.dart';

import 'package:catalogo/app/domain/entities/carrinho.dart';
import 'package:catalogo/app/services/carrinho_service.dart';

part 'carrinho_controller.g.dart';

class CarrinhoController = _CarrinhoControllerBase with _$CarrinhoController;

abstract class _CarrinhoControllerBase with Store {
  CarrinhoService service;
  PedidoService pedidoService;

  _CarrinhoControllerBase(
    this.service,
    this.pedidoService,
  ) {
    _init();
  }

  @observable
  List<CarrinhoItens>? carrinho;

  @observable
  List<CarrinhoItens>? pedido;

  @action
  _init() async {
    carrinho = service.items.values.toList();
  }

  @action
  criarPedido() {
    var total = service.totalAmount;
    var id = service.idCarrinho;
    print(total);
    print(id);
    pedidoService.addPedido(total, id);
  }
}
