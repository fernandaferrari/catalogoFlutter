import 'package:catalogo/app/domain/entities/pedidos.dart';

abstract class IPedidoRepository {
  //Metodo para salvar pedidos
  save(Pedido pedido);

  //remove;

  //Metodo para listar todos os pedidos
  Future<List<Pedido>> AllPedidos();
}
