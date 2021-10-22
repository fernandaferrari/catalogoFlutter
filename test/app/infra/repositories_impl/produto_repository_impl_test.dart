import 'package:catalogo/app/infra/repositories_impl/produto_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final repository = ProdutoRepositoryImpl();
  test('Lista de produtos ...', () async {
    final list = await repository.AllProdutos();

    expect(list.isNotEmpty, equals(true));
  });
}
