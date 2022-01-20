import 'package:catalogo/infra/remote_repository/remote_produto_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

void main() {
  test('Lista de produtos ...', () async {
    //final repository = ProdutoRepositoryMock();
    final client = Client();
    final repository = RemoteProdutoRepository(client);
    final list = await repository.allProdutos();

    expect(list.isNotEmpty, equals(true));
  });

  test('ultimo item na api produtos ...', () async {
    //final repository = ProdutoRepositoryMock();
    final client = Client();
    final repository = RemoteProdutoRepository(client);
    final list = await repository.allProdutos();

    expect(list.last.id, 15);
  });
}
