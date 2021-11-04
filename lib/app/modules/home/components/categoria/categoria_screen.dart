import 'package:catalogo/app/domain/entities/categoria.dart';
import 'package:catalogo/app/infra/api_repository/api_categoria_repository.dart';
import 'package:catalogo/app/infra/api_repository/api_produto_repository.dart';
import 'package:catalogo/app/modules/home/home_controller.dart';
import 'package:catalogo/app/services/produto_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class CategoriaScreen extends StatefulWidget {
  BuildContext context;

  CategoriaScreen(this.context);

  @override
  State<CategoriaScreen> createState() => _CategoriaScreenState();
}

class _CategoriaScreenState
    extends ModularState<CategoriaScreen, HomeController> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filtro por Categoria'),
      content: Container(
        height: 290,
        width: 290,
        child: Observer(builder: (_) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: controller.categoria!.length,
              itemBuilder: (context, index) {
                var item = controller.categoria![index];
                return ListTile(
                  title: GestureDetector(
                      onTap: () {
                        controller.buscarCategoria(item);
                        Navigator.pop(context);
                      },
                      child: Text(item.name.toString())),
                );
              });
        }),
      ),
    );
  }
}
