import 'package:catalogo/domain/entities/pedidos.dart';
import 'package:catalogo/domain/interfaces/repository/pedido_repository.dart';
import 'package:catalogo/domain/interfaces/services/pedido_service.dart';

class PedidoService implements IPedidoService {
  PedidoRepository repository;
  PedidoService({required this.repository});

  List<Pedido> _items = [];

  @override
  List<Pedido> get items {
    return [..._items];
  }

  @override
  addPedido({required Pedido pedido}) async {
    await repository.savePedido(pedido: pedido);
  }

  @override
  Future<List<Pedido>> allPedidos() async {
    return _items = await repository.allPedidos();
  }
}
