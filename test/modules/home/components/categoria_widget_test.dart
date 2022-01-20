import 'package:catalogo/domain/entities/categoria.dart';
import 'package:catalogo/domain/entities/produto.dart';
import 'package:catalogo/pages/home/components/categoria_widget.dart';
import 'package:catalogo/pages/home/home_controller.dart';
import 'package:catalogo/main/modular/home_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:modular_test/modular_test.dart';

class HomeControllerMock extends Mock implements HomeController {
  PostExpectation mockCategoria() => when(categoria);
  void mockCats() => mockCategoria()
      .thenAnswer((realInvocation) => [Categoria(id: 2, name: 'Teste')]);

  PostExpectation mockBuscaCategoriaCall() => when(buscarCategoria(any));
  void mockBuscaCat() => mockCategoria().thenAnswer(
      (realInvocation) => [Produto(id: any, categoryId: any, name: any)]);
}

void main() {
  initModule(HomeModule(),
      replaceBinds: [Bind.factory((i) => HomeControllerMock())]);
  //var navigatorMock = MyNavigatorMock();
  late HomeControllerMock controller;

  setUp(() {
    controller = HomeControllerMock();
  });

  testWidgets(
      'Test verifica estado inicial do produtowidget quando possui item...',
      (tester) async {
    controller.mockCats();
    await tester
        .pumpWidget(MaterialApp(home: CategoriaScreen(controller: controller)));

    await tester.pump();

    expect(find.text('Filtro por Categoria'), findsOneWidget);
    expect(find.text('Teste'), findsOneWidget);

    await tester.tap(find.text('Teste'));
    await tester.pump();

    verify(controller.buscarCategoria(any)).called(1);
  });
}
