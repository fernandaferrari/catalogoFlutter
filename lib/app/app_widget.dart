import 'package:catalogo/app/modules/home/home_page.dart';
import 'package:catalogo/app/services/carrinho_service.dart';
import 'package:catalogo/app/services/pedido_service.dart';
import 'package:catalogo/app/services/produto_service.dart';
import 'package:catalogo/app/utils/app_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Catalogo',
      theme: ThemeData(primaryColor: Colors.purple),
    ).modular();
  }
}
