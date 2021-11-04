import 'package:catalogo/app/infra/repositories_impl/carrinho_repository_impl.dart';
import 'package:catalogo/app/modules/cart/carrinho_controller.dart';
import 'package:catalogo/app/modules/cart/cart_page.dart';
import 'package:catalogo/app/services/carrinho_service.dart';
import 'package:catalogo/app/services/pedido_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';

class CarrinhoModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => CarrinhoRepository()),
        Bind((i) => CarrinhoService()),
        Bind((i) => CarrinhoController(
            i.get<CarrinhoService>(), i.get<PedidoService>())),
        Bind((i) => PedidoService()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute, child: (_, args) => CartPage()),
      ];
}
