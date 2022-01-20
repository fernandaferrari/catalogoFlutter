import 'package:catalogo/domain/entities/carrinho.dart';
import 'package:catalogo/main/modular/carrinho_module.dart';
import 'package:catalogo/pages/cart/carrinho_controller.dart';
import 'package:catalogo/pages/cart/cart_page.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

class CarrinhoControllerMock extends Mock implements CarrinhoController {
  CarrinhoControllerMock() {
    loadCarrinhoMock();
    loadTotalCart();
  }

  When carrinhoCall() => when(() => carrinho);
  void loadCarrinhoMock() => carrinhoCall().thenAnswer((_) => [
        CarrinhoItens(
            id: faker.guid.random.string(10),
            productId: faker.guid.random.string(10),
            title: faker.food.restaurant(),
            quantity: 1,
            price: faker.guid.random.decimal())
      ]);

  When totalCall() => when(() => total);
  void loadTotalCart() =>
      totalCall().thenAnswer((_) => faker.randomGenerator.decimal());

  When removeCall() => when(() => removeCarrinho(any()));
  void mockRemoveCart() => removeCall().thenAnswer((_) => _);
}

void main() {
  initModule(CarrinhoModule(), replaceBinds: [
    Bind((i) => CarrinhoControllerMock()),
  ]);

  late CarrinhoControllerMock controller;

  setUp(() {
    controller = CarrinhoControllerMock();
  });

  testWidgets('estago inicial do cartPage quanto tem itens ...',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CartPage(),
    ));

    await tester.pump();

    expect(find.text('Carrinho'), findsOneWidget);
  });

  testWidgets('ao clicar no botão comprar...', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CartPage(),
    ));

    expect(find.text('Carrinho'), findsOneWidget);

    await tester.tap(find.byType(TextButton));

    await tester.pumpAndSettle();

    verifyNever(() => controller.criarPedido(any(), any()));
  });

  testWidgets('ao cliclar no nãp widget dismissible para excluir item...',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CartPage(),
    ));

    expect(find.text('Carrinho'), findsOneWidget);

    //await tester.tap(find.byType(Dismissible));

    await tester.drag(find.byType(Dismissible), const Offset(-500.0, 0.0));

    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);

    expect(find.text('Tem certeza?'), findsOneWidget);

    await tester.tap(find.text('Não'));

    await tester.pumpAndSettle();

    expect(find.text('Carrinho'), findsOneWidget);
  });

  testWidgets('ao cliclar no sim widget dismissible para excluir item...',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CartPage(),
    ));

    controller.mockRemoveCart();

    expect(find.text('Carrinho'), findsOneWidget);

    //await tester.tap(find.byType(Dismissible));

    await tester.drag(find.byType(Dismissible), const Offset(-500.0, 0.0));

    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);

    expect(find.text('Tem certeza?'), findsOneWidget);

    await tester.tap(find.text('Sim'));

    await tester.pumpAndSettle();

    verifyNever(() => controller.removeCarrinho(any()));
  });
}
