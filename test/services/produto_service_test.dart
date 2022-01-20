import 'package:catalogo/domain/entities/categoria.dart';
import 'package:catalogo/domain/entities/produto.dart';
import 'package:catalogo/infra/services/produto_service.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/api_categoria_repository_mock.dart';
import '../mocks/produto_repository_mock.dart';

void main() {
  late LocalProdutoRepositoryMock repositoryProduto;
  late ProdutoService service;
  late RemoteCategoriaRepositoryMock repositoryCategoria;
  late Produto produto;

  setUp(() {
    repositoryProduto = LocalProdutoRepositoryMock();
    repositoryCategoria = RemoteCategoriaRepositoryMock();
    service = ProdutoService(
        repositoryProduto: repositoryProduto,
        repositoryCategoria: repositoryCategoria);
    repositoryProduto.mockload();
    repositoryCategoria.mockloadCategoria();
    produto = Produto(
      id: 8,
      name: 'Teste',
      description: 'Teste',
      photo: 'teste.png',
      price: 200,
      categoryId: 4,
      isFavorite: 0,
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

  List<Produto> addItem(
      {int? id,
      int? categoryId,
      int? isFavorite,
      String? name,
      String? photo,
      num? price}) {
    final produto = Produto(
        id: id ?? 4,
        categoryId: categoryId ?? 7,
        description: 'mais barato do brasil',
        isFavorite: isFavorite ?? 0,
        name: name ?? 'Pão de alho',
        photo: photo ?? 'image.jpg',
        price: price ?? 10.00);
    List<Produto> item = [produto];
    return item;
  }

  List<Categoria> addCat() {
    List<Categoria> item = [Categoria(id: 2, name: 'baralho')];
    return item;
  }

  test('teste serItensProduto', () {
    var item = addItem();

    service.setItensProduto(item);

    var value = service.itemProduto;

    expect(item.last.name, 'Pão de alho');
    expect(value.length, 1);
  });

  test('Teste itensCategoria', () {
    var itemCategoria = addCat();
    service.setItensCategoria(itemCategoria);

    var value = service.itemCategoria;

    expect(itemCategoria.last.name, 'baralho');
    expect(value.length, 1);
  });

  test('Testando list favorite itens', () {
    var itens = addItem(isFavorite: 1);

    service.setItensProduto(itens);

    var item = service.favoriteItems;

    expect(item.last.id, 4);
  });

  test('lista busca por nome do produto', () {
    var itens = addItem(name: 'Sabão');
    service.setItensProduto(itens);
    String text = 'Tv';
    var item = service.searchItens(text);

    var item2 = addItem(name: 'Tv');
    service.setItensProduto(item2);
    var itemBusca = service.searchItens(text);

    var itemVazio = service.searchItens("");

    expect(item.isEmpty, true);
    expect(itemBusca.last.name, 'Tv');
    expect(itemVazio.last.name, 'Tv');
  });

  test('busca por categoria', () {
    var item2 = addItem(name: 'pife', categoryId: 2);
    service.setItensProduto(item2);
    var cat = addCat();
    var item = service.produtoCategory(cat: cat.first);

    expect(item.last.name, 'pife');
  });

  test('Teste load produtos', () async {
    await service.loadProducts();

    verify(() => repositoryProduto.allProdutos()).called(1);
  });

  test('Teste save produtos', () async {
    await service.saveProduto(produto: produto);

    verify(() => repositoryProduto.save(produto: any(named: "produto")));
  });

  test('Teste exluir produtos', () async {
    await service.removeProduto(id: produto.id!);

    verify(() => repositoryProduto.remove((produto.id!)));
  });

  test('Teste load Categoria', () async {
    await service.loadCategoria();

    verify(() => repositoryCategoria.allCategoria()).called(1);
  });

  test('chamada function toggleFavorite', () async {
    await service.toggleFavorite(produto);

    verify(() => repositoryProduto.toggleFavorite(produto)).called(1);
  });
}
