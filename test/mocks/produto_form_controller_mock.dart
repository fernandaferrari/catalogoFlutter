import 'package:catalogo/domain/entities/categoria.dart';
import 'package:catalogo/pages/formulario/produto_form_controller.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';

class ProdutoFormControllerMock extends Mock implements ProdutoFormController {
  ProdutoFormControllerMock() {
    loadCategoriaMock();
    when(() => save(produto: any(named: 'produto'))).thenAnswer((_) => _);
  }

  When saveCall() => when(() => save(produto: any(named: 'produto')));
  void saveMockError() => saveCall().thenThrow(Exception());

  When itemCatCall() => when(() => itemCategoria);
  void loadCategoriaMock() => itemCatCall().thenAnswer((_) => [
        Categoria(id: faker.guid.random.integer(20), name: faker.food.cuisine())
      ]);

  @override
  List<String> categoria() {
    return ["1-Paçoca"];
  }

  @override
  buscaCategoria(item) {
    return "1";
  }
}
