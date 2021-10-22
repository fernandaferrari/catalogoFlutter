import 'package:catalogo/app/infra/repositories_impl/pedido_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final repository = PedidoRepositoryImpl();
  test('Lista de pedidos ...', () async {
    final list = await repository.AllPedidos();

    expect(list.isNotEmpty, equals(true));
  });
}
