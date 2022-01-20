import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:catalogo/pages/drawer/app_drawer.dart';
import 'package:catalogo/pages/home/components/bolsa_widget.dart';
import 'package:catalogo/pages/home/components/busca_nome_produto.dart';
import 'package:catalogo/pages/home/components/menu_itens_button.dart';
import 'package:catalogo/pages/home/components/produto_widget.dart';
import 'package:catalogo/pages/home/home_controller.dart';

import '../drawer/app_drawer.dart';

// ignore: use_key_in_widget_constructors
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo'),
        actions: [
          BolsaWidget(
            child: IconButton(
              key: const Key('Cart'),
              onPressed: () {
                Modular.to.pushNamed('/carrinho/');
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
          menuItens(controller: controller, context: context),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.loadProdutos(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 30,
              child: Card(
                child: BuscaNome(controller: controller),
              ),
            ),
            Expanded(
              child: Observer(
                name: 'produtos',
                builder: (_) {
                  if (controller.produtos!.isEmpty) {
                    return const Center(
                      child: Text("Nenhum dado encontrado!!"),
                    );
                  }

                  return ListView.builder(
                    itemCount: controller.produtos!.length,
                    itemBuilder: (context, index) {
                      var item = controller.produtos![index];

                      return ProdutoWidget(
                        item: item,
                        controller: controller,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}
