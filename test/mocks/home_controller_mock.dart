import 'package:catalogo/domain/entities/carrinho.dart';
import 'package:catalogo/domain/entities/categoria.dart';
import 'package:catalogo/domain/entities/produto.dart';
import 'package:catalogo/pages/home/home_controller.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';

class HomeControllerMock extends Mock implements HomeController {
  HomeControllerMock() {
    loadProdutosMock();
    loadCategoriaMock();
    loadCartMock();
  }

  List<Produto> produto = [
    Produto(
      id: faker.randomGenerator.integer(10),
      name: faker.food.cuisine(),
      photo: faker.internet.httpUrl(),
      description: faker.food.cuisine(),
      isFavorite: 0,
      price: faker.randomGenerator.decimal(),
      categoryId: faker.randomGenerator.integer(10),
    )
  ];

  List<Categoria> cat = [
    Categoria(
      id: faker.randomGenerator.integer(10),
      name: faker.food.cuisine(),
    )
  ];

  Map<String, CarrinhoItens> car = {
    "1": CarrinhoItens(
        id: faker.guid.guid(),
        productId: faker.guid.guid(),
        title: faker.food.cuisine(),
        quantity: 1,
        price: faker.randomGenerator.decimal())
  };

  When mockProdutosCall() => when(() => produtos);
  void loadProdutosMock() =>
      mockProdutosCall().thenAnswer((realInvocation) => produto);

  When mockloadCategoria() => when(() => categoria);
  void loadCategoriaMock() =>
      mockloadCategoria().thenAnswer((realInvocation) => cat);

  When mockloadCart() => when(() => cart);
  void loadCartMock() => mockloadCart().thenAnswer((realInvocation) => car);

  When mockFiltroAllCall() => when(() => filtro(any));
  void mockFiltroAllMock() => mockFiltroAllCall().thenReturn(produto);

  When mockFavoriteCall() => when(() => toggleIsFavorite(any));
  void mockFavorite() => mockFavoriteCall().thenAnswer((_) => _);

  @override
  Future<void> loadProdutos() async {
    await super.noSuchMethod(Invocation.method(#loadProdutos, null));
  }
}
