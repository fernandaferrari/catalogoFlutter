import 'package:catalogo/domain/entities/produto.dart';
import 'package:catalogo/pages/formulario/produto_form_controller.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/gerenciar_controller_mock.dart';
import '../../mocks/produto_service_mock.dart';

void main() {
  late ProdutoServiceMock serviceProduto;
  late ProdutoFormController sut;
  late GerenciarControllerMock gerenciarController;
  setUp(() {
    serviceProduto = ProdutoServiceMock();
    gerenciarController = GerenciarControllerMock();
    sut = ProdutoFormController(
        service: serviceProduto, gerenciarController: gerenciarController);
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

  testWidgets(
      'busca categoria que separa o id de uma listString para salvar prod ...',
      (tester) async {
    var item = "2-Categoria";
    var result = sut.buscaCategoria(item);
    expect(result, "2");
  });

  testWidgets(
      'testando function que busca a categoria e transforma em uma list<string>  ...',
      (tester) async {
    serviceProduto.mockitemCat();
    var item = sut.categoria();

    expect(item!.length, 1);
  });

  testWidgets(
      'tentando error da function que busca a categoria e transforma em uma list<string>  ...',
      (tester) async {
    serviceProduto.mockitemCatError();
    var item = sut.categoria();

    expect(item, ["Erro tente novamente"]);
  });

  testWidgets('testando chamada da function save  ...', (tester) async {
    final produto = Produto(
      id: faker.guid.random.integer(20),
      name: faker.person.name(),
      description: faker.person.name(),
      photo: faker.image.image(),
      price: faker.guid.random.decimal(),
      categoryId: faker.guid.random.integer(10),
      isFavorite: 0,
    );

    sut.save(produto: produto);

    verify(() => serviceProduto.saveProduto(produto: any(named: "produto")))
        .called(1);
  });

  testWidgets('testando chamada da function save com exceção ...',
      (tester) async {
    when(() => serviceProduto.saveProduto(produto: any(named: "produto")))
        .thenThrow(Exception());
    final produto = Produto(
      id: faker.guid.random.integer(20),
      name: faker.person.name(),
      description: faker.person.name(),
      photo: faker.image.image(),
      price: faker.guid.random.decimal(),
      categoryId: faker.guid.random.integer(10),
      isFavorite: 0,
    );

    final future = sut.save(produto: produto);

    expect(future, throwsA(const TypeMatcher<Exception>()));
  });
}
