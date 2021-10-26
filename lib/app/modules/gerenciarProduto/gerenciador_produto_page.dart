import 'package:catalogo/app/domain/entities/produto.dart';
import 'package:catalogo/app/infra/utils/err/http_exception.dart';
import 'package:catalogo/app/modules/gerenciarProduto/form/produto_form.dart';
import 'package:catalogo/app/modules/gerenciarProduto/gerenciador_produto_controller.dart';
import 'package:catalogo/app/shared/app_drawer.dart';
import 'package:catalogo/app/services/produto_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

class GerenciadorProdutoPage extends StatefulWidget {
  @override
  _GerenciadorProdutoPageState createState() => _GerenciadorProdutoPageState();
}

class _GerenciadorProdutoPageState
    extends ModularState<GerenciadorProdutoPage, GerenciadorProdutoController> {
  @override
  Widget build(BuildContext context) {
    final msg = ScaffoldMessenger.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Gerenciar Produtos')),
        actions: [
          IconButton(
            onPressed: () =>
                //Modular.to.navigate("/formulario", arguments: Produto()),
                Modular.to.pushNamed("/formulario"),
            icon: Icon(Icons.add),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Container(
        child: Observer(builder: (_) {
          if (controller.itemProduto == null) {
            return Center(
              child: FloatingActionButton(
                onPressed: () {},
                child: Text('Tente novamente!'),
              ),
            );
          }

          if (controller.itemProduto!.length == 0) {
            return Center(
              child: Text("Nenhum dado encontrado!!"),
            );
          }

          return ListView.builder(
              itemCount: controller.itemProduto!.length,
              itemBuilder: (ctx, i) {
                var produto = controller.itemProduto![i];

                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(produto.photo!),
                      ),
                      title: Text(produto.name!),
                      trailing: Container(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              color: Theme.of(context).primaryColor,
                              onPressed: () {
                                Modular.to.pushNamed("/formulario");
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              color: Theme.of(context).errorColor,
                              onPressed: () {
                                showDialog<bool>(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text('Excluir Produto'),
                                    content: Text('Tem certeza?'),
                                    actions: [
                                      TextButton(
                                        child: Text('Não'),
                                        onPressed: () =>
                                            Navigator.of(ctx).pop(false),
                                      ),
                                      TextButton(
                                        child: Text('Sim'),
                                        onPressed: () =>
                                            Navigator.of(ctx).pop(true),
                                      ),
                                    ],
                                  ),
                                ).then((value) async {
                                  if (value ?? false) {
                                    try {
                                      // await Provider.of<ProdutoService>(
                                      //   context,
                                      //   listen: false,
                                      // ).removeProduto(produto);
                                    } on HttpException catch (error) {
                                      msg.showSnackBar(
                                        SnackBar(
                                          content: Text(error.toString()),
                                        ),
                                      );
                                    }
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                  ],
                );
              });
        }),
      ),
    );
  }
}
