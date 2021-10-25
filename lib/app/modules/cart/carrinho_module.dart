import 'package:catalogo/app/infra/repositories_impl/carrinho_repository_impl.dart';
import 'package:catalogo/app/infra/repositories_impl/pedido_repository_impl.dart';
import 'package:catalogo/app/modules/cart/carrinho_controller.dart';
import 'package:catalogo/app/modules/cart/cart_page.dart';
import 'package:catalogo/app/services/carrinho_service.dart';
import 'package:catalogo/app/services/pedido_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CarrinhoModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => CarrinhoRepository()),
        Bind((i) => CarrinhoService(i.get<CarrinhoRepository>())),
        Bind((i) => CarrinhoController(
            i.get<CarrinhoService>(), i.get<PedidoService>())),
        Bind((i) => PedidoService(i.get<PedidoRepositoryImpl>())),
        Bind((i) => PedidoRepositoryImpl()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute, child: (_, args) => CartPage()),
      ];
}
