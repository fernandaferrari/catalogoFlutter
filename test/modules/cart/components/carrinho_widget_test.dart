import 'package:catalogo/domain/entities/carrinho.dart';
import 'package:catalogo/pages/cart/carrinho_controller.dart';
import 'package:catalogo/main/modular/carrinho_module.dart';
import 'package:catalogo/pages/cart/components/carrinho_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:modular_test/modular_test.dart';

class CarrinhoControllerMock extends Mock implements CarrinhoController {}

void main() {
  initModule(CarrinhoModule(),
      replaceBinds: [Bind.factory((i) => CarrinhoControllerMock())]);
  late CarrinhoControllerMock controller;
  late CarrinhoItens item;

  setUp(() {
    controller = CarrinhoControllerMock();
    item = CarrinhoItens(
        id: '1', productId: '1', title: 'Sabão', quantity: 1, price: 10.00);
  });

  testWidgets(
      'Test verifica estado inicial do carrinhowidget quando possui item...',
      (tester) async {
    //var navigatorMock = MyNavigatorMock();
    // when(navigatorMock.pushNamed('/'))
    //     .thenAnswer((_) async => const CartPage());

    await tester.pumpWidget(MaterialApp(
        home: CarrinhoWidget(
      controller: controller,
      item: item,
    )));
    await tester.pump();

    expect(
        find.text('Total: R\$ ${item.price * item.quantity}'), findsOneWidget);
  });
}
