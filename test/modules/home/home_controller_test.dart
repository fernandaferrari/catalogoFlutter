import 'package:catalogo/domain/entities/carrinho.dart';
import 'package:catalogo/domain/entities/categoria.dart';
import 'package:catalogo/domain/entities/produto.dart';
import 'package:catalogo/infra/services/carrinho_service.dart';
import 'package:catalogo/pages/home/home_controller.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/produto_service_mock.dart';

class CarrinhoServiceMock extends Mock implements CarrinhoService {
  When itensCartCall() => when(() => items);
  void itensMock() => itensCartCall().thenAnswer((invocation) => {
        "4": CarrinhoItens(
            id: '3', productId: '8', title: 'Teste', quantity: 2, price: 300)
      });
}

void main() {
  late ProdutoServiceMock service;
  late CarrinhoServiceMock cartService;
  late HomeController sut;
  late Produto item;

  setUp(() {
    cartService = CarrinhoServiceMock();
    cartService.itensMock();
    service = ProdutoServiceMock();
    sut = HomeController(cartService: cartService, service: service);
    item = Produto(
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
    registerFallbackValue(Categoria(
        id: faker.guid.random.integer(20), name: faker.person.name()));
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

  test('Teste toggle isFavorite ...', () async {
    service.mockIsFavorite();
    sut.toggleIsFavorite(item);

    verify(() => service.toggleFavorite(item));

    item = Produto(
      id: 8,
      name: 'Teste',
      description: 'Teste',
      photo: 'teste.png',
      price: 200,
      categoryId: 4,
      isFavorite: 0,
    );
    sut.toggleIsFavorite(item);

    verify(() => service.toggleFavorite(item));
  });

  test('Teste load Produtos ...', () async {
    sut.loadProdutos();

    verify(() => service.loadProducts());
  });

  test('Teste filter option ...', () async {
    service.itemProdutos();
    var value = "FilterOptions.all";
    sut.filtro(value);

    verify(() => service.itemProduto);

    service.mockItensFav();
    value = "FilterOptions.favorite";
    sut.filtro(value);

    verify(() => service.favoriteItems);
  });

  test('Chamada function adicionar carrinho', () {
    sut.addCarrinho(item);

    verify(() => cartService.addItem(item)).called(1);
  });

  test('Chamada remove um item', () {
    sut.removeUmItem(item.id.toString());

    verify(() => cartService.removeSingleItem(item.id.toString())).called(1);
  });
  test('Teste buscar produto por nome ...', () async {
    service.mockNome([item]);
    String text = 'Teste';
    sut.buscaNome(text);

    verify(() => service.searchItens(text)).called(1);
  });

  test('Teste buscar produto por Categoria ...', () async {
    service.mockBuscaCat();
    var cat =
        Categoria(id: faker.guid.random.integer(50), name: faker.person.name());
    sut.buscarCategoria(cat);

    verify(() => service.produtoCategory(cat: any(named: "cat"))).called(1);
  });
}
