import 'package:catalogo/domain/entities/carrinho.dart';
import 'package:catalogo/infra/remote_repository/remote_pedido_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:catalogo/domain/entities/pedidos.dart';

void main() {
  test('api pedido repository ...', () async {
    final client = Client();

    final repository = RemotePedidoRepository(client: client);

    List<Pedido> teste = await repository.allPedidos();

    expect(teste.isNotEmpty, equals(true));
  });

  test('salvando pedido', () async {
    final client = Client();

    final repository = RemotePedidoRepository(client: client);

    List<CarrinhoItens> itens = [
      CarrinhoItens(
          id: '3', productId: '2', title: 'Teste', quantity: 1, price: 3000)
    ];

    var pedido = Pedido(total: 3000, products: itens);

    await repository.savePedido(pedido: pedido);

    List<Pedido> teste = await repository.allPedidos();

    teste.last;

    expect(teste.last.total, pedido.total);
  });
}
