import 'package:catalogo/domain/entities/carrinho.dart';
import 'package:catalogo/domain/entities/pedidos.dart';
import 'package:catalogo/domain/entities/produto.dart';
import 'package:catalogo/pages/cart/carrinho_controller.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/carrinho_service_mock.dart';
import '../../mocks/pedido_service_mock.dart';

void main() {
  late PedidoServiceMock servicePedido;
  late CarrinhoServiceMock serviceCarrinho;
  late CarrinhoController controller;
  late CarrinhoItens cart;

  setUp(() {
    servicePedido = PedidoServiceMock();
    serviceCarrinho = CarrinhoServiceMock();

    controller = CarrinhoController(
      service: serviceCarrinho,
      pedidoService: servicePedido,
    );
    cart = CarrinhoItens(
        id: '3', productId: '4', title: 'Teste', quantity: 2, price: 300);
  });

  setUpAll(() {
    registerFallbackValue(Pedido(total: faker.guid.random.decimal(), products: [
      CarrinhoItens(
          id: faker.guid.guid(),
          productId: faker.guid.guid(),
          title: faker.food.restaurant(),
          quantity: 1,
          price: faker.guid.random.decimal())
    ]));
  });

  test('Chamada da function removeItem ...', () async {
    controller.removeCarrinho(cart.id);

    verify(() => serviceCarrinho.removeItem(cart.id)).called(1);
  });

  test('Chamada addItem', () {
    var produto =
        Produto(id: 4, name: "Teste", description: "testando", price: 150.00);
    controller.addItem(produto);

    verify(() => serviceCarrinho.addItem(produto));
  });

  test('removendo um item do carrinho', () {
    controller.removeUmItem(cart.id);

    verify(() => serviceCarrinho.removeSingleItem(cart.id));
  });

  test('limpando os itens do carrinho', () {
    controller.itensClear();

    verify(() => serviceCarrinho.clear());
    var item = serviceCarrinho.items.values.toList();

    expect(item.last.id, '3');
  });

  test('criando um pedido', () {
    var item = serviceCarrinho.items.values.toList();
    var total = serviceCarrinho.totalAmount;
    controller.criarPedido(item, total);

    verify(() => servicePedido.addPedido(pedido: any(named: "pedido")));
  });
}
