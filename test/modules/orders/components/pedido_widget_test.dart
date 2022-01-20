import 'package:catalogo/domain/entities/carrinho.dart';
import 'package:catalogo/domain/entities/pedidos.dart';
import 'package:catalogo/domain/entities/produto.dart';
import 'package:catalogo/pages/orders/components/pedido_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Pedido? pedido;

  setUp(() {
    pedido = Pedido(date: DateTime(2021), id: '1', total: 3000.00, products: [
      CarrinhoItens(
          date: DateTime(2021),
          id: '1',
          productId: '1',
          title: 'Teste',
          quantity: 1,
          price: 3000.00,
          produtos: [
            Produto(
                id: 1,
                name: "Teste",
                description: "testando",
                price: 3000.00,
                isFavorite: 0,
                photo: "image.jpg",
                categoryId: 4)
          ])
    ]);
  });

  testWidgets(
      'Test verifica estado inicial do produtowidget quando possui item...',
      (tester) async {
    await tester.pumpWidget(MaterialApp(home: PedidoWidget(pedido)));

    await tester.pump();

    expect(find.text('R\$ ${pedido!.total.toStringAsFixed(2)}'), findsWidgets);
  });

  testWidgets('Test click no IconButton para expandir card pedidos...',
      (tester) async {
    await tester.pumpWidget(MaterialApp(home: PedidoWidget(pedido)));

    await tester.pump();

    expect(find.text('R\$ ${pedido!.total.toStringAsFixed(2)}'), findsWidgets);

    await tester.tap(find.byKey(const Key("expanded")));

    await tester.pump();

    expect(find.text("Teste"), findsWidgets);
  });
}
