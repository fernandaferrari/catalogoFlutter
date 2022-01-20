import 'package:catalogo/domain/entities/produto.dart';
import 'package:catalogo/infra/services/carrinho_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CarrinhoService service;

  setUp(() {
    service = CarrinhoService();
  });

  testWidgets('carrinho service adicionando um item...', (tester) async {
    final product = Produto(id: 2, name: 'Martelo', price: 50.00);
    service.addItem(product);

    var item = service.items;

    expect(item.values.last.title, 'Martelo');
  });

  testWidgets('carrinho service adicionando dois itens iguais...',
      (tester) async {
    final product = Produto(id: 2, name: 'Martelo', price: 50.00);
    service.addItem(product);
    final product2 = Produto(id: 2, name: 'Martelo', price: 50.00);
    service.addItem(product2);
    var item = service.items;

    expect(item.values.last.quantity, 2);
  });

  testWidgets('removendo um item do carrinho...', (tester) async {
    final product = Produto(id: 2, name: 'Martelo', price: 50.00);
    service.addItem(product);
    final product2 = Produto(id: 2, name: 'Martelo', price: 50.00);
    service.addItem(product2);

    var item = service.items;
    service.removeSingleItem('2');
    var item2 = service.items;

    expect(item2.values.last.quantity, 1);
    expect(item.values.last.quantity, 2);
  });

  testWidgets('removendo um unico item...', (tester) async {
    final product = Produto(id: 2, name: 'Martelo', price: 50.00);
    service.addItem(product);

    service.removeSingleItem('2');
    var item2 = service.items;
    expect(item2.values.isEmpty, item2.isEmpty);
  });

  testWidgets('removendo todos produtos com mesmo id...', (tester) async {
    final product = Produto(id: 2, name: 'Martelo', price: 50.00);
    service.addItem(product);
    final product2 = Produto(id: 2, name: 'Martelo', price: 50.00);
    service.addItem(product2);

    service.removeItem('2');
    var item = service.items;

    expect(item.isEmpty, true);
  });

  test('Limpando carrinho', () {
    final product = Produto(id: 2, name: 'Martelo', price: 50.00);
    service.addItem(product);
    final product2 = Produto(id: 2, name: 'Martelo', price: 50.00);
    service.addItem(product2);

    service.clear();
    var item = service.items;

    expect(item.isEmpty, true);
  });

  test('Testando o valor total do carrinho', () {
    final product = Produto(id: 2, name: 'Martelo', price: 50.00);
    service.addItem(product);
    final product2 = Produto(id: 2, name: 'Martelo', price: 50.00);
    service.addItem(product2);

    var item = service.totalAmount;

    expect(item, 100.00);
  });
}
