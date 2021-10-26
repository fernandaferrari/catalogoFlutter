import 'package:catalogo/app/modules/cart/carrinho_module.dart';
import 'package:catalogo/app/modules/gerenciarProduto/gerenciador_produto_module.dart';
import 'package:catalogo/app/modules/home/home_module.dart';
import 'package:catalogo/app/modules/orders/pedido_module.dart';
import 'package:catalogo/app/shared/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute,
        module: HomeModule(), transition: TransitionType.fadeIn),
    ModuleRoute("/gerenciar",
        module: GerenciadorProdutoModule(),
        transition: TransitionType.rightToLeft),
    ModuleRoute("/carrinho", module: CarrinhoModule()),
    ModuleRoute("/pedidos",
        module: PedidoModule(), transition: TransitionType.fadeIn),
  ];

  @override
  Widget get bootstrap => AppWidget();
}
