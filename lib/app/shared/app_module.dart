import 'package:catalogo/app/dominio/repositories/produto_repository.dart';
import 'package:catalogo/app/modules/home/home_page.dart';
import 'package:catalogo/app/modules/home/home_store.dart';
import 'package:catalogo/app/shared/app_widget.dart';
import 'package:catalogo/app/shared/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => HomeStore(i.get())),
    Bind((i) => ProdutoRepository()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => HomePage()),
  ];

  @override
  Widget get bootstrap => AppWidget();
}
