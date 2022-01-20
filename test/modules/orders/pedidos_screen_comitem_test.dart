import 'package:catalogo/domain/entities/carrinho.dart';
import 'package:catalogo/domain/entities/pedidos.dart';
import 'package:catalogo/domain/entities/produto.dart';
import 'package:catalogo/main/modular/pedido_module.dart';
import 'package:catalogo/pages/orders/pedido_controller.dart';
import 'package:catalogo/pages/orders/pedidos_screen.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

class PedidoControllerMock extends Mock implements PedidoController {
  PedidoControllerMock() {
    loadPedido();
  }

  When mockPedidoCall() => when(() => pedidos);
  void loadPedido() => mockPedidoCall().thenAnswer((invocation) => pedido);

  List<Pedido> pedido = [
    Pedido(
        id: faker.guid.guid(),
        date: DateTime.now(),
        total: faker.guid.random.decimal(),
        products: [
          CarrinhoItens(
              id: faker.guid.guid(),
              productId: faker.guid.guid(),
              title: faker.food.cuisine(),
              quantity: 1,
              price: faker.guid.random.decimal(),
              date: DateTime.now(),
              produtos: [
                Produto(
                  id: 8,
                  name: "Teste",
                  price: 2,
                )
              ]),
        ])
  ];

  @override
  Future<List<Pedido>> reloadPedidos() async {
    pedidos = pedido;
    return pedido;
  }
}

void main() {
  initModule(PedidoModule(), replaceBinds: [
    Bind((i) => PedidoControllerMock()),
  ]);

  setUp(() {});

  testWidgets('pedidos screen ...', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: PedidosScreen(),
    ));

    await tester.pump();

    expect(find.text("Meus pedidos"), findsOneWidget);
  });
}
