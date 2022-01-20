import 'package:catalogo/domain/entities/carrinho.dart';
import 'package:catalogo/domain/entities/categoria.dart';
import 'package:catalogo/domain/entities/produto.dart';
import 'package:catalogo/domain/interfaces/services/carrinho_service.dart';
import 'package:catalogo/domain/interfaces/services/produto_service.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';

class ProdutoServiceMock extends Mock
    implements IProdutoService, ICarrinhoService {
  ProdutoServiceMock() {
    loadMock();
    loadMockCategoria();

    when(() => saveProduto(produto: any(named: "produto")))
        .thenAnswer((_) async => produto);
  }

  final produto = Produto(
    id: faker.guid.random.integer(20),
    name: faker.person.name(),
    description: faker.person.name(),
    photo: faker.image.image(),
    price: faker.guid.random.decimal(),
    categoryId: faker.guid.random.integer(10),
    isFavorite: 0,
  );

  //Inicializa junto com a class
  When mockInitProduto() => when(() => loadProducts());
  void loadMock() => mockInitProduto().thenAnswer((_) async => [produto]);

  When mockInitCategoria() => when(() => loadCategoria());
  void loadMockCategoria() => mockInitCategoria().thenAnswer((_) async => [
        Categoria(id: faker.guid.random.integer(20), name: faker.food.cuisine())
      ]);

  When mockitemCatCall() => when(() => itemCategoria);
  void mockitemCat() => mockitemCatCall().thenReturn([
        Categoria(id: faker.guid.random.integer(20), name: faker.food.cuisine())
      ]);

  List<Categoria> cats = [];
  void mockitemCatError() => mockitemCatCall().thenReturn(cats);

  When mockInitCart() => when(() => items);
  void mockLoadCart() => mockInitCart().thenAnswer((_) => [
        CarrinhoItens(
            id: '3',
            productId: '3',
            title: 'Teste',
            quantity: 1,
            price: 2000.00)
      ]);

  //function toggleFavorite
  When mockToggle() => when(() => toggleFavorite(produto));
  void mockIsFavorite() => mockToggle().thenAnswer((_) => _);

  //function searchItens
  When mockBuscaNome() => when(() => searchItens(any()));
  void mockNome(List<Produto> produtos) =>
      mockBuscaNome().thenAnswer((_) => produtos);

  //get itemProduto
  When itensProduto() => when(() => itemProduto);
  void itemProdutos() => itensProduto().thenReturn([produto]);

  //get favoriteItems
  When itensFavorite() => when(() => favoriteItems);
  void mockItensFav() => itensFavorite().thenReturn([produto]);

  //function addItem
  When addCartsCall() => when(() => addItem(produto));
  void mockAddCart() => addCartsCall().thenAnswer((_) async => _);

  When prodCategoryCall() =>
      when(() => produtoCategory(cat: any(named: 'cat')));
  void mockBuscaCat() => prodCategoryCall().thenAnswer((_) => [produto]);
}
