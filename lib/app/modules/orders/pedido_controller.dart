import 'package:catalogo/app/domain/entities/pedidos.dart';
import 'package:catalogo/app/services/pedido_service.dart';
import 'package:mobx/mobx.dart';
part 'pedido_controller.g.dart';

class PedidoController = _PedidoControllerBase with _$PedidoController;

abstract class _PedidoControllerBase with Store {
  PedidoService service;

  _PedidoControllerBase(this.service) {
    _init();
  }

  @observable
  List<Pedido>? pedidos;

  @action
  Future _init() async {
    pedidos = await service.loadPedidos();
  }
}
