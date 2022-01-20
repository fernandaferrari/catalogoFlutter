import 'package:catalogo/domain/entities/pedidos.dart';

abstract class PedidoRepository {
  Future<List<Pedido>> allPedidos();
  savePedido({required Pedido pedido});
}
