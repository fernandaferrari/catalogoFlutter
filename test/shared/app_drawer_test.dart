import 'package:catalogo/main/modular/app_module.dart';
import 'package:catalogo/main/modular/gerenciador_produto_module.dart';
import 'package:catalogo/main/modular/home_module.dart';
import 'package:catalogo/main/modular/pedido_module.dart';
import 'package:catalogo/pages/drawer/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

class ModularNavigateMock extends Mock implements IModularNavigator {}

void main() {
  initModule(AppModule());
  GlobalKey<ScaffoldState>? scaffoldKey;
  final navigate = ModularNavigateMock();
  Modular.navigatorDelegate = navigate;

  setUp(() {
    scaffoldKey = GlobalKey<ScaffoldState>();
  });

  Future<void> loadDrawer(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          key: scaffoldKey,
          drawer: const AppDrawer(),
        ),
      ),
    );

    scaffoldKey!.currentState!.openDrawer();
  }

  testWidgets(
      'Verificando se no App Drawer encontra text Loja, Pedido Finalizado e Gerenciar Prod ...',
      (tester) async {
    await loadDrawer(tester);

    await tester.pump();

    expect(find.text('Loja'), findsOneWidget);
    expect(find.text('Pedidos Finalizados'), findsOneWidget);
    expect(find.text('Gerenciar Produtos'), findsOneWidget);
  });

  testWidgets('Testando rotas para home...', (tester) async {
    when(() => navigate.pushNamed(
          '/',
        )).thenAnswer((_) async => initModule(HomeModule()));

    await loadDrawer(tester);

    await tester.pump();

    final finder = find.byKey(const Key("loja"));

    await tester.ensureVisible(finder);

    await tester.pumpAndSettle();

    await tester.tap(finder);

    expect(finder, findsOneWidget);

    verify(() => navigate.pushNamed(
          '/',
        )).called(1);
  });

  testWidgets('Testando rota para pedidos...', (tester) async {
    when(() => navigate.pushNamed('/pedidos/'))
        .thenAnswer((_) async => initModule(PedidoModule()));

    await loadDrawer(tester);

    await tester.pump();

    final finder = find.byKey(const Key("pedido"));

    await tester.ensureVisible(finder);

    await tester.pumpAndSettle();

    await tester.tap(finder);

    expect(finder, findsOneWidget);

    verify(() => navigate.pushNamed('/pedidos/')).called(1);
  });

  testWidgets('Testando rota para gerenciar...', (tester) async {
    when(() => navigate.popAndPushNamed('/gerenciar/'))
        .thenAnswer((_) async => initModule(GerenciadorProdutoModule()));

    await loadDrawer(tester);

    await tester.pump();

    final finder = find.byKey(const Key("gerenciar"));

    await tester.ensureVisible(finder);

    await tester.pumpAndSettle();

    await tester.tap(finder);

    expect(finder, findsOneWidget);

    verify(() => navigate.popAndPushNamed('/gerenciar/')).called(1);
  });
}
