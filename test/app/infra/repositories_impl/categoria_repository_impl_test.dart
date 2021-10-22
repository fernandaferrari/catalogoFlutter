import 'package:catalogo/app/infra/repositories_impl/categoria_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final repository = CategoriaRepositoryImpl();
  test('Lista de produtos ...', () async {
    final list = await repository.AllCategorias();

    expect(list.isNotEmpty, equals(true));
  });
}
