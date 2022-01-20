import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:catalogo/pages/home/home_controller.dart';

class CategoriaScreen extends StatelessWidget {
  final HomeController controller;

  const CategoriaScreen({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filtro por Categoria'),
      content: SizedBox(
        height: 290,
        width: 290,
        child: Observer(
            name: 'cat',
            builder: (_) {
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
