import 'package:catalogo/app/app_widget.dart';
import 'package:catalogo/app/modules/home/home_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute,
        module: HomeModule(), transition: TransitionType.fadeIn),
    // ModuleRoute("/cart",
    //     module: CarrinhoModule(), transition: TransitionType.rightToLeft),
    // ModuleRoute("/pedido",
    //     module: PedidoModule(), transition: TransitionType.fadeIn),
  ];

  @override
  Widget get bootstrap => AppWidget();
}
