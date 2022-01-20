import 'package:catalogo/domain/entities/produto.dart';
import 'package:catalogo/pages/home/components/produto_widget.dart';
import 'package:catalogo/main/modular/home_module.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../mocks/home_controller_mock.dart';

void main() {
  initModule(HomeModule(),
      replaceBinds: [Bind.factory((i) => HomeControllerMock())]);
  //var navigatorMock = MyNavigatorMock();
  late HomeControllerMock controller;
  late Produto item;

  setUp(() {
    controller = HomeControllerMock();
    item = controller.produtos!.last;
  });

  testWidgets(
      'Test verifica estado inicial do produtowidget quando possui item...',
      (tester) async {
    await mockNetworkImagesFor(() async => await tester.pumpWidget(MaterialApp(
            home: ProdutoWidget(
          controller: controller,
          item: item,
        ))));

    await tester.pump();

    expect(find.text(item.name!), findsOneWidget);
  });

  testWidgets('Testando cahamada quando clica no botão para favoritar item...',
      (tester) async {
    controller.mockFavorite();
    await mockNetworkImagesFor(() async => await tester.pumpWidget(MaterialApp(
            home: ProdutoWidget(
          controller: controller,
          item: item,
        ))));

    await tester.pump();

    await tester.tap(find.byKey(const Key("favorite")));

    await tester.pumpAndSettle();

    verify(() => controller.toggleIsFavorite(item));
  });

  testWidgets('Testando chamada da function adicionar um item ao carrinho..',
      (tester) async {
    Produto produto = Produto(
      id: faker.randomGenerator.integer(10),
      name: faker.food.cuisine(),
      photo: faker.internet.httpUrl(),
      description: faker.food.cuisine(),
      isFavorite: 0,
      price: faker.randomGenerator.decimal(),
      categoryId: faker.randomGenerator.integer(10),
    );

    when(() => controller.removeUmItem(produto.id)).thenAnswer((_) => _);

    when(() => controller.addCarrinho(produto)).thenAnswer((_) => _);

    await mockNetworkImagesFor(() async => await tester.pumpWidget(MaterialApp(
            home: ProdutoWidget(
          controller: controller,
          item: item,
        ))));

    await tester.pump();

    await tester.tap(find.byKey(const Key("remove")));
  });
}
