import 'package:catalogo/domain/entities/pedidos.dart';
import 'package:catalogo/infra/services/pedido_service.dart';
import 'package:mobx/mobx.dart';
part 'pedido_controller.g.dart';

class PedidoController = _PedidoControllerBase with _$PedidoController;

abstract class _PedidoControllerBase with Store {
  PedidoService service;

  _PedidoControllerBase({required this.service}) {
    init();
  }

  @observable
  List<Pedido>? pedidos;

  @action
  Future<List<Pedido>> init() async {
    return pedidos = await service.allPedidos();
  }

  @action
  Future<List<Pedido>> reloadPedidos() async {
    return pedidos = await service.allPedidos();
  }
}
