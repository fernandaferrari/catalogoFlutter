import 'package:catalogo/domain/entities/pedidos.dart';

abstract class IPedidoService {
  List<Pedido> get items;
  addPedido({required Pedido pedido});
  Future<List<Pedido>> allPedidos();
}
