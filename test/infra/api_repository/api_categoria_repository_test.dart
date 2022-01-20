import 'package:catalogo/infra/remote_repository/remote_categoria_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

void main() {
  test('api categoria repository ...', () async {
    final client = Client();
    final repository = RemoteCategoriaRepository(client: client);

    final list = await repository.allCategoria();
    expect(list.isNotEmpty, equals(true));
  });

  test('ultimo item da apiCategoria ...', () async {
    final client = Client();
    final repository = RemoteCategoriaRepository(client: client);

    final list = await repository.allCategoria();
    expect(list.last.id, 5);
  });
}
