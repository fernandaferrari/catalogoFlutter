import 'package:catalogo/domain/entities/carrinho.dart';
import 'package:catalogo/domain/entities/pedidos.dart';
import 'package:catalogo/domain/interfaces/repository/pedido_repository.dart';
import 'package:mocktail/mocktail.dart';

class PedidoRepositoryMock extends Mock implements PedidoRepository {
  PedidoRepositoryMock() {
    mockSave();
  }

  When mockLoadCall() => when(() => allPedidos());

  void mockload() => mockLoadCall().thenAnswer((_) async => [
        Pedido(total: 3000, products: [
          CarrinhoItens(
              id: '2', productId: '2', title: 'teste', quantity: 1, price: 3000)
        ])
      ]);

  When mockSaveCall() => when(() => savePedido(
          pedido: Pedido(total: 3000, products: [
        CarrinhoItens(
            id: '2', productId: '2', title: 'teste', quantity: 1, price: 3000)
      ])));
  void mockSave() => mockSaveCall().thenAnswer((_) async => _);
}
