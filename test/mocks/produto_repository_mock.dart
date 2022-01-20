import 'package:catalogo/domain/entities/produto.dart';
import 'package:catalogo/domain/interfaces/repository/produto_repository.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';

class LocalProdutoRepositoryMock extends Mock implements ProdutoRepository {
  LocalProdutoRepositoryMock() {
    when(() => save(produto: any(named: "produto")))
        .thenAnswer((invocation) async => produto);
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

  When mockLoadCall() => when(() => allProdutos());

  void mockload() => mockLoadCall().thenAnswer((_) async => [
        Produto(
          id: 8,
          name: 'Teste',
          description: 'Teste',
          photo: 'teste.png',
          price: 200,
          categoryId: 4,
          isFavorite: 0,
        )
      ]);
}
