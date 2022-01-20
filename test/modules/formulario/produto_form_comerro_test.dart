import 'package:catalogo/domain/entities/categoria.dart';
import 'package:catalogo/domain/entities/produto.dart';
import 'package:catalogo/main/modular/produto_formulario_module.dart';
import 'package:catalogo/pages/formulario/produto_form_controller.dart';
import 'package:catalogo/pages/formulario/produto_form_page.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

class ProdutoFormControllerMock extends Mock implements ProdutoFormController {
  ProdutoFormControllerMock() {
    loadCategoriaMock();
    saveMockError();
  }

  When saveCall() => when(() => save(produto: any(named: 'produto')));
  void saveMockError() => saveCall().thenThrow(Exception());

  When itemCatCall() => when(() => itemCategoria);
  void loadCategoriaMock() => itemCatCall().thenAnswer((_) => [
        Categoria(id: faker.guid.random.integer(20), name: faker.food.cuisine())
      ]);

  // When mockSaveCall() => when(() => save(produto: any(named: 'produto')));
  // void loadSaveMock() => itemCatCall().thenAnswer((_) => _);

  @override
  List<String> categoria() {
    return ["1-Paçoca"];
  }

  @override
  buscaCategoria(item) {
    return "1";
  }
}

class ModularNavigateMock extends Mock implements IModularNavigator {}

void main() {
  initModule(ProdutoFormularioModule(),
      replaceBinds: [Bind.factory((i) => ProdutoFormControllerMock())]);
  final navigate = ModularNavigateMock();
  Modular.navigatorDelegate = navigate;

  late ProdutoFormControllerMock controller;
  late Produto product;

  setUp(() {
    controller = ProdutoFormControllerMock();
    product = Produto(
        id: null,
        name: faker.person.name(),
        description: faker.person.name(),
        price: faker.randomGenerator.decimal(),
        photo: faker.internet.httpUrl(),
        categoryId: 1,
        isFavorite: 0);
  });

  setUpAll(() {
    registerFallbackValue(Produto());
  });

  testWidgets('testando salvar com valores validos porem retornando saveError',
      (tester) async {
    when(() => navigate.canPop()).thenAnswer((_) => true);

    controller.saveMockError();

    await mockNetworkImagesFor(
        () async => await tester.pumpWidget(const MaterialApp(
              home: ProdutoFormulario(
                produto: null,
              ),
            )));

    await tester.pump();

    expect(find.text('Formulário Produto'), findsOneWidget);

    await mockNetworkImagesFor(() async {
      await tester.enterText(find.byKey(const Key("nome")), product.name!);
      await tester.enterText(
          find.byKey(const Key("descricao")), product.description!);
      await tester.enterText(
          find.byKey(const Key("valor")), product.price.toString());
      await tester.enterText(find.byKey(const Key("imagem")), product.photo!);

      await tester.tap(find.byKey(const Key("cats")));
      await tester.pump();
      await tester.tap(find.text("1-Paçoca").last);
      await tester.pump();
    });
    expect(find.byType(ElevatedButton), findsOneWidget);

    final finder = find.byType(ElevatedButton);

    await tester.ensureVisible(finder);
    await tester.pump();

    await tester.tap(finder);

    await tester.pump();

    expect(find.byType(TextButton), findsOneWidget);

    await tester.tap(find.byType(TextButton));

    verify(() => navigate.canPop()).called(1);
  });
}
