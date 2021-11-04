import 'package:catalogo/app/modules/orders/pedido_controller.dart';
import 'package:catalogo/app/modules/orders/pedidos_screen.dart';
import 'package:catalogo/app/services/pedido_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PedidoModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => PedidoService()),
        Bind((i) => PedidoController(i.get<PedidoService>()))
      ];

  @override
  List<ModularRoute> get routes =>
      [ChildRoute(Modular.initialRoute, child: (_, args) => PedidosScreen())];
}
