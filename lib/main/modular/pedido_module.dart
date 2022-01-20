import 'package:catalogo/infra/remote_repository/remote_pedido_repository.dart';
import 'package:catalogo/infra/services/pedido_service.dart';
import 'package:catalogo/pages/orders/pedido_controller.dart';
import 'package:catalogo/pages/orders/pedidos_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';

class PedidoModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => RemotePedidoRepository(client: Client())),
        Bind((i) => PedidoService(repository: i.get<RemotePedidoRepository>())),
        Bind((i) => PedidoController(service: i.get<PedidoService>()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute,
            child: (_, args) => const PedidosScreen())
      ];
}
