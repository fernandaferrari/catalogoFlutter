import 'package:catalogo/domain/entities/produto.dart';
import 'package:catalogo/pages/gerenciarProduto/gerenciador_produto_controller.dart';
import 'package:catalogo/main/modular/gerenciador_produto_module.dart';
import 'package:catalogo/pages/gerenciarProduto/gerenciador_produto_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:mobx/mobx.dart' hide when;

class GerenciarControllerMock extends Mock
    implements GerenciadorProdutoController {
  ObservableList<Produto> list = ObservableList<Produto>.of([]);

  @override
  ObservableList<Produto> get itemProdutos => list;
}

void main() {
  initModule(GerenciadorProdutoModule(),
      replaceBinds: [Bind.factory((i) => GerenciarControllerMock())]);

  setUp(() {});

  testWidgets('testando estado inicial gerenciar produto com item ...',
      (tester) async {
    await mockNetworkImagesFor(() async => await tester.pumpWidget(
          const MaterialApp(
            home: GerenciadorProdutoPage(),
          ),
        ));

    await tester.pump();

    expect(find.text('Gerenciar Produtos'), findsOneWidget);
    expect(find.text('Sem itens lançados'), findsOneWidget);
  });
}
