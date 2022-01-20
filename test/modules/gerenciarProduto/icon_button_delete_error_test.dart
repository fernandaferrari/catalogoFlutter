import 'package:catalogo/domain/entities/produto.dart';
import 'package:catalogo/main/modular/gerenciador_produto_module.dart';
import 'package:catalogo/pages/gerenciarProduto/gerenciador_produto_controller.dart';
import 'package:catalogo/pages/gerenciarProduto/gerenciador_produto_page.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' hide when;
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

class ModularNavigateMock extends Mock implements IModularNavigator {}

class GerenciarControllerMock extends Mock
    implements GerenciadorProdutoController {
  GerenciarControllerMock() {
    // mockItens(produtos);
    when(() => excluirProduto(id: any(named: "id"))).thenThrow(Exception);
  }

  List<Produto> produtos = [
    Produto(
      id: faker.randomGenerator.integer(10),
      name: faker.food.cuisine(),
      photo: faker.internet.httpUrl(),
      description: faker.food.cuisine(),
      isFavorite: 0,
      price: faker.randomGenerator.decimal(),
      categoryId: faker.randomGenerator.integer(10),
    )
  ];

  When mockExcluirCall() => when(() => excluirProduto(id: any(named: "id")));
  void mockExcluirError() => mockExcluirCall().thenThrow(Exception());

  @override
  Future<void> reloadProdutos() async {
    await super.noSuchMethod(Invocation.method(#reloadProdutos, null));
  }

  ObservableList<Produto> list = ObservableList<Produto>.of([
    Produto(
      id: faker.randomGenerator.integer(10),
      name: faker.food.cuisine(),
      photo: faker.internet.httpUrl(),
      description: faker.food.cuisine(),
      isFavorite: 0,
      price: faker.randomGenerator.decimal(),
      categoryId: faker.randomGenerator.integer(10),
    )
  ]);

  @override
  ObservableList<Produto> get itemProdutos => list;

  // Observable<Exception?> erro = Observable<Exception?>(null));

  // @override
  // Observable<Exception> get error => erro;
}

main() {
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
  testWidgets('botton excluir quando a exception no excluir...',
      (tester) async {
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
  });
}
