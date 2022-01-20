import 'package:catalogo/main/modular/app_module.dart';
import 'package:catalogo/main/modular/carrinho_module.dart';
import 'package:catalogo/main/modular/home_module.dart';
import 'package:catalogo/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../mocks/home_controller_mock.dart';

class ModularNavigateMock extends Mock implements IModularNavigator {}

void main() {
  initModule(HomeModule(), replaceBinds: [Bind((i) => HomeControllerMock())]);

  final navigate = ModularNavigateMock();
  Modular.navigatorDelegate = navigate;

  late HomeControllerMock controller;

  setUp(() {
    controller = HomeControllerMock();
    controller.mockFiltroAllMock();
  });

  testWidgets('home page inicial ...', (tester) async {
    await mockNetworkImagesFor(() async => await tester.pumpWidget(
          MaterialApp(
            home: HomePage(),
          ),
        ));

    await tester.pump();

    expect(find.text('Catálogo'), findsOneWidget);
  });

  testWidgets('menu appBar homePage option all...', (tester) async {
    await mockNetworkImagesFor(() async => await tester.pumpWidget(
          MaterialApp(
            home: HomePage(),
          ),
        ));

    await tester.pump();

    await tester.tap(find.byKey(const Key("menu")));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key("all")));

    await tester.pumpAndSettle();

    verifyNever(() => controller.filtro(any));
  });

  testWidgets('menu appBar homePage option favorite...', (tester) async {
    await mockNetworkImagesFor(() async => await tester.pumpWidget(
          MaterialApp(
            home: HomePage(),
          ),
        ));

    await tester.pump();

    await tester.tap(find.byKey(const Key("menu")));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key("fav")));

    await tester.pumpAndSettle();

    verifyNever(() => controller.filtro(any));
  });

  testWidgets('menu appBar homePage option category...', (tester) async {
    await mockNetworkImagesFor(() async => await tester.pumpWidget(
          MaterialApp(
            home: HomePage(),
          ),
        ));

    await tester.pump();

    await tester.tap(find.byKey(const Key("menu")));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key("cat")));

    await tester.pumpAndSettle();

    expect(find.text('Filtro por Categoria'), findsOneWidget);
  });

  testWidgets('testando function onRefresh...', (tester) async {
    // ignore: avoid_returning_null_for_void
    when(() => controller.loadProdutos()).thenAnswer((_) async => null);
    await mockNetworkImagesFor(() async => await tester.pumpWidget(
          MaterialApp(
            key: const Key('Teste'),
            home: HomePage(),
          ),
        ));
    await tester.drag(find.byType(RefreshIndicator), const Offset(0, 500));

    await tester.pumpAndSettle();

    verifyNever(() => controller.loadProdutos());
  });

  testWidgets('testando navegação para carrinhoPage...', (tester) async {
    initModule(AppModule());
    when(() => navigate.pushNamed('/carrinho/'))
        .thenAnswer((_) async => initModule(CarrinhoModule()));

    await mockNetworkImagesFor(() async => await tester.pumpWidget(
          MaterialApp(
            key: const Key('Teste'),
            home: HomePage(),
          ),
        ));
    await tester.pump();

    expect(find.byKey(const Key("Cart")), findsOneWidget);

    await tester.tap(find.byKey(const Key("Cart")));

    verify(() => navigate.pushNamed('/carrinho/')).called(1);
  });
}
