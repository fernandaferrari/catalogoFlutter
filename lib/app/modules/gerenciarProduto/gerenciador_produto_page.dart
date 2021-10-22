import 'package:catalogo/app/modules/gerenciarProduto/components/gerenciar_produto_item.dart';
import 'package:catalogo/app/modules/home/components/app_drawer.dart';
import 'package:catalogo/app/services/produto_service.dart';
import 'package:catalogo/app/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GerenciadorProdutoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProdutoService produtos = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Gerenciar Produtos')),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.FORM_PRODUTO);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Container(
        child: ListView.builder(
            itemCount: produtos.itensCount,
            itemBuilder: (ctx, i) => Column(
                  children: [
                    GerenciarProdutoItem(produtos.itemProduto[i]),
                    Divider(),
                  ],
                )),
      ),
    );
  }
}
