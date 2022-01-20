import 'package:catalogo/domain/entities/categoria.dart';
import 'package:catalogo/domain/interfaces/repository/categoria_repository.dart';
import 'package:mocktail/mocktail.dart';

class RemoteCategoriaRepositoryMock extends Mock
    implements CategoriaRepository {
  When mockLoadCall() => when(() => allCategoria());

  void mockloadCategoria() =>
      mockLoadCall().thenAnswer((_) async => [Categoria(id: 8, name: 'Teste')]);
}
