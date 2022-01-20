import 'package:catalogo/domain/entities/carrinho.dart';
import 'package:catalogo/domain/entities/pedidos.dart';
import 'package:catalogo/infra/services/pedido_service.dart';
import 'package:mocktail/mocktail.dart';

class PedidoServiceMock extends Mock implements PedidoService {
  PedidoServiceMock() {
    mockPedidos();
    initRepo();
  }

  When addPedidoCall() => when(() => addPedido(
          pedido: Pedido(total: 300, products: [
        CarrinhoItens(
            id: '3', productId: '4', title: 'Teste', quantity: 2, price: 300)
      ])));
  void addPedidoMock() => addPedidoCall().thenAnswer((_) => _);

  When initRepoCall() => when(() => repository);
  void initRepo() => initRepoCall().thenAnswer((_) => _);

  When mockAllPedidos() => when(() => allPedidos());
  void mockPedidos() => mockAllPedidos().thenAnswer((_) async => [
        Pedido(total: 300, products: [
          CarrinhoItens(
              id: '3', productId: '4', title: 'Teste', quantity: 2, price: 300)
        ])
      ]);
}
