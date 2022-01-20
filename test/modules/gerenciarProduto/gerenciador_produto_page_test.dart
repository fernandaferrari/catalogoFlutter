import 'package:catalogo/domain/entities/produto.dart';
import 'package:catalogo/main/modular/app_module.dart';
import 'package:catalogo/main/modular/gerenciador_produto_module.dart';
import 'package:catalogo/main/modular/produto_formulario_module.dart';
import 'package:catalogo/pages/gerenciarProduto/gerenciador_produto_page.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../mocks/gerenciar_controller_mock.dart';

class ModularNavigateMock extends Mock implements IModularNavigator {}

void main() {
  initModule(GerenciadorProdutoModule(),
      replaceBinds: [Bind.factory((i) => GerenciarControllerMock())]);

  late GerenciarControllerMock controller;
  final navigate = ModularNavigateMock();
  Modular.navigatorDelegate = navigate;

  setUp(() {
    controller = GerenciarControllerMock();
  });

  setUpAll(() {
    registerFallbackValue(Produto(
      id: faker.guid.random.integer(20),
      name: faker.person.name(),
      description: faker.person.name(),
      photo: faker.image.image(),
      price: faker.guid.random.decimal(),
      categoryId: faker.guid.random.integer(10),
      isFavorite: 0,
    ));
  });

  testWidgets('testando estado inicial gerenciar produto com item ...',
      (tester) async {
    await mockNetworkImagesFor(() async => await tester.pumpWidget(
          const MaterialApp(
            home: GerenciadorProdutoPage(),
          ),
        ));

    await tester.pump();

    expect(find.text('Gerenciar Produtos'), findsOneWidget);
  });

  testWidgets('botton excluir ...', (tester) async {
    // ignore: avoid_returning_null_for_void
    when(() => controller.reloadProdutos()).thenAnswer((_) async => null);
    when(() => navigate.pop(true)).thenAnswer((_) async => true);

    await mockNetworkImagesFor(() async => await tester.pumpWidget(
          const MaterialApp(
            home: GerenciadorProdutoPage(),
          ),
        ));

    expect(find.text('Gerenciar Produtos'), findsOneWidget);

    await tester.tap(find.byKey(const Key("excluir")));

    await tester.pump();

    expect(find.text('Sim'), findsOneWidget);

    await tester.tap(find.text('Sim'));

    await tester.pump();

    verifyNever(() => controller.excluirProduto(id: any(named: "id")));
  });

  testWidgets('testando o refreshIndicator ...', (tester) async {
    // ignore: avoid_returning_null_for_void
    when(() => controller.reloadProdutos()).thenAnswer((_) async => null);
    await mockNetworkImagesFor(() async => await tester.pumpWidget(
          const MaterialApp(
            home: GerenciadorProdutoPage(),
          ),
        ));

    expect(find.text('Gerenciar Produtos'), findsOneWidget);
    expect(find.byType(RefreshIndicator), findsOneWidget);

    await tester.drag(find.byType(RefreshIndicator), const Offset(0, 500));

    await tester.pumpAndSettle();

    verifyNever(() => controller.reloadProdutos());
  });

  testWidgets('testando navegação para formulario...', (tester) async {
    initModule(AppModule());
    when(() => navigate.pushNamed('/formulario/'))
        .thenAnswer((_) async => initModule(ProdutoFormularioModule()));

    await mockNetworkImagesFor(() async => await tester.pumpWidget(
          const MaterialApp(
            home: GerenciadorProdutoPage(),
          ),
        ));

    await tester.pump();

    expect(find.byKey(const Key("adicionar item")), findsOneWidget);

    await tester.tap(find.byKey(const Key("adicionar item")));

    verify(() => navigate.pushNamed('/formulario/')).called(1);
  });

  testWidgets('testando navegaçao ao clicar no button editar...',
      (tester) async {
    initModule(AppModule());
    when(() => navigate.pushNamed('/formulario/',
            arguments: any(named: "arguments")))
        .thenAnswer((_) async => initModule(ProdutoFormularioModule()));

    await mockNetworkImagesFor(() async => await tester.pumpWidget(
          const MaterialApp(
            home: GerenciadorProdutoPage(),
          ),
        ));

    await tester.pump();

    expect(find.byKey(const Key("edit")), findsOneWidget);

    await tester.tap(find.byKey(const Key("edit")));

    verify(() => navigate.pushNamed('/formulario/',
        arguments: any(named: "arguments"))).called(1);
  });

  testWidgets('testando navegaçao ao clicar no button excluir...',
      (tester) async {
    initModule(AppModule());
    when(() => navigate.pop(false)).thenAnswer((_) async => _);

    await mockNetworkImagesFor(() async => await tester.pumpWidget(
          const MaterialApp(
            home: GerenciadorProdutoPage(),
          ),
        ));

    await tester.tap(find.byKey(const Key("excluir")));

    await tester.pumpAndSettle();

    expect(find.text('Não'), findsOneWidget);

    await tester.tap(find.text('Não'));

    verify(() => navigate.pop(false)).called(1);
  });
}
