import 'package:catalogo/domain/entities/carrinho.dart';
import 'package:catalogo/infra/services/carrinho_service.dart';
import 'package:mocktail/mocktail.dart';

class CarrinhoServiceMock extends Mock implements CarrinhoService {
  CarrinhoServiceMock() {
    loadCart();
    loadTotalAmount();
  }

  When loadCartCall() => when(() => items);

  void loadCart() => loadCartCall().thenAnswer((_) => {
        "4": CarrinhoItens(
            id: '3', productId: '4', title: 'Teste', quantity: 2, price: 300)
      });

  When totalAmountCall() => when(() => totalAmount);
  void loadTotalAmount() => totalAmountCall().thenAnswer((_) => 2000.00);

  When mockClearCall() => when(() => clear);
  void mockClear() => mockClearCall().thenReturn({});
}
