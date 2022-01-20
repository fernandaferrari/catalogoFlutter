import 'package:catalogo/domain/entities/produto.dart';
import 'package:catalogo/pages/gerenciarProduto/gerenciador_produto_controller.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/produto_service_mock.dart';

void main() {
  late ProdutoServiceMock serviceProduto;
  late GerenciadorProdutoController sut;
  late Produto produto;
  setUp(() {
    serviceProduto = ProdutoServiceMock();

    sut = GerenciadorProdutoController(service: serviceProduto);
    produto = Produto(
      id: 8,
      name: 'Teste',
      description: 'Teste',
      photo: 'teste.png',
      price: 200,
      categoryId: 4,
      isFavorite: 1,
    );
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

  test('Reload produtos quando utilizado o refresh na tela Gerenciar Produtos',
      () async {
    await sut.reloadProdutos();

    verify(() => serviceProduto.loadProducts());
  });

  test('Testando chamada excluirProduto GerenciarController', () async {
    sut.excluirProduto(id: produto.id!);

    verify(() => serviceProduto.removeProduto(id: produto.id!)).called(1);

    var itemProduto = await serviceProduto.loadProducts();

    expect(itemProduto.length, 1);
  });

  test('Testando chamada function setProduto', () async {
    sut.setProdutos(produto);

    var item = sut.itemProdutos;

    expect(item.length, 2);
  });

  test('Testando chamada function excluir produto quando ocorre uma exceção',
      () async {
    when(() => serviceProduto.removeProduto(id: any(named: "id")))
        .thenThrow(Exception);

    // sut.error.observe(expectAsync1(
    //     (error) => expect(error.newValue, E)));

    sut.excluirProduto(id: produto.id!);

    //expect(sut.error.value, Exception("Erro ao excluir item!"));
  });
}
