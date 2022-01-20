import 'package:catalogo/main/modular/carrinho_module.dart';
import 'package:catalogo/pages/cart/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:modular_test/modular_test.dart';

import '../../mocks/my_navigator_mock.dart';

void main() {
  var navigatorMock = MyNavigatorMock();
  testWidgets('Test inicialização module Carrinho', (tester) async {
    initModule(CarrinhoModule());
    when(navigatorMock.pushNamed('/'))
        .thenAnswer((_) async => const CartPage());

    await tester.pumpWidget(const MaterialApp(home: CartPage()));
    await tester.pump();

    expect(find.text('Carrinho'), findsOneWidget);
  });
}
