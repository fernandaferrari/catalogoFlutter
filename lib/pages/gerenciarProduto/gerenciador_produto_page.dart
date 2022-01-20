import 'package:catalogo/pages/gerenciarProduto/components/icon_button_delete.dart';
import 'package:catalogo/pages/gerenciarProduto/gerenciador_produto_controller.dart';
import 'package:catalogo/pages/drawer/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'components/icon_button_edit.dart';

class GerenciadorProdutoPage extends StatefulWidget {
  const GerenciadorProdutoPage({Key? key}) : super(key: key);

  @override
  _GerenciadorProdutoPageState createState() => _GerenciadorProdutoPageState();
}

class _GerenciadorProdutoPageState
    extends ModularState<GerenciadorProdutoPage, GerenciadorProdutoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Gerenciar Produtos')),
        actions: [
          IconButton(
            key: const Key('adicionar item'),
            onPressed: () {
              Modular.to.pushNamed("/formulario/");
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => controller.reloadProdutos(),
        child: Observer(builder: (_) {
          if (controller.itemProdutos.isEmpty) {
            return const Center(
              child: Text('Sem itens lançados'),
            );
          }

          return ListView.builder(
              itemCount: controller.itemProdutos.length,
              itemBuilder: (ctx, i) {
                var produto = controller.itemProdutos[i];

                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(produto.photo!),
                      ),
                      title: Text(produto.name!),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButtonEdit(produto: produto),
                            IconButtonDelete(
                              controller: controller,
                              produto: produto,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                );
              });
        }),
      ),
    );
  }
}
