import 'package:catalogo/app/dominio/repositories/produto_repository.dart';
import 'package:catalogo/app/modules/home/home_module.dart';
import 'package:catalogo/app/modules/home/home_page.dart';
import 'package:catalogo/app/modules/home/home_store.dart';
import 'package:catalogo/app/shared/app_widget.dart';
import 'package:catalogo/app/shared/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
    // ModuleRoute('/categoria', module: CategoriaModule()),
    // ModuleRoute('/carrinho', module: CarrinhoModule()),
    // ModuleRoute('/pedido', module: PedidoModule()),
    // ModuleRoute('/cadastro', module: CadastroModule()),
  ];

  @override
  Widget get bootstrap => AppWidget();
}
