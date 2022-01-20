import 'package:catalogo/domain/entities/produto.dart';
import 'package:catalogo/pages/gerenciarProduto/gerenciador_produto_controller.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobx/mobx.dart' hide when;

class GerenciarControllerMock extends Mock
    implements GerenciadorProdutoController {
  GerenciarControllerMock() {
    // mockItens(produtos);
    when(() => excluirProduto(id: any(named: "id"))).thenAnswer((_) => null);
  }

  List<Produto> produtos = [
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

  When mockExcluirCall() => when(() => excluirProduto(id: any(named: "id")));
  void mockExcluirError() => mockExcluirCall().thenThrow(Exception());

  List<Produto> produts = [
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

  @override
  Future<void> reloadProdutos() async {
    await super.noSuchMethod(Invocation.method(#reloadProdutos, null));
  }

  ObservableList<Produto> list = ObservableList<Produto>.of([
    Produto(
      id: faker.randomGenerator.integer(10),
      name: faker.food.cuisine(),
      photo: faker.internet.httpUrl(),
      description: faker.food.cuisine(),
      isFavorite: 0,
      price: faker.randomGenerator.decimal(),
      categoryId: faker.randomGenerator.integer(10),
    )
  ]);

  @override
  ObservableList<Produto> get itemProdutos => list;
}
