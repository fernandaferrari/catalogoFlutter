import 'package:catalogo/domain/entities/carrinho.dart';
import 'package:catalogo/domain/entities/pedidos.dart';
import 'package:catalogo/infra/services/pedido_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/pedido_repository_mock.dart';

void main() {
  late PedidoRepositoryMock repository;
  late PedidoService sut;
  late Pedido pedido;

  setUp(() {
    repository = PedidoRepositoryMock();
    repository.mockload();
    sut = PedidoService(repository: repository);
    pedido = Pedido(total: 3000, products: [
      CarrinhoItens(
          id: '2', productId: '2', title: 'teste', quantity: 1, price: 3000)
    ]);
  });
  test('call return pedidos quando invocado AllPedidos ...', () async {
    await sut.allPedidos();

    verify(() => repository.allPedidos()).called(1);
  });

  test('pedido service ...', () async {
    await sut.addPedido(pedido: pedido);

    verify(() => repository.savePedido(pedido: pedido));
  });

  test('get itens Pedidos ...', () async {
    await sut.allPedidos();
    final item = sut.items;

    expect(item.last.total, 3000);
  });
}
