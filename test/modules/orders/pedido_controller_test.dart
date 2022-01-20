import 'package:catalogo/pages/orders/pedido_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../mocks/pedido_service_mock.dart';

void main() {
  late PedidoServiceMock service;
  late PedidoController sut;

  setUp(() {
    service = PedidoServiceMock();
    service.mockPedidos();
    sut = PedidoController(service: service);
  });

  test('Testando reload pedidos ...', () async {
    sut.reloadPedidos();

    verify(() => service.allPedidos());
  });
}
