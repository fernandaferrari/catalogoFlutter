import 'package:catalogo/infra/remote_repository/remote_pedido_repository.dart';
import 'package:catalogo/infra/services/carrinho_service.dart';
import 'package:catalogo/infra/services/pedido_service.dart';
import 'package:catalogo/pages/cart/carrinho_controller.dart';
import 'package:catalogo/pages/cart/cart_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';

class CarrinhoModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => CarrinhoService()),
        Bind((i) => CarrinhoController(
            service: i.get<CarrinhoService>(),
            pedidoService: i.get<PedidoService>())),
        Bind((i) => RemotePedidoRepository(client: Client())),
        Bind((i) => PedidoService(repository: i.get<RemotePedidoRepository>())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute, child: (_, args) => const CartPage()),
      ];
}
