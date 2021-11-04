import 'package:catalogo/app/domain/entities/pedidos.dart';
import 'package:catalogo/app/modules/cart/carrinho_controller.dart';
import 'package:catalogo/app/services/carrinho_service.dart';
import 'package:catalogo/app/services/pedido_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ModularState<CartPage, CarrinhoController> {
  @override
  Widget build(BuildContext context) {
    final CarrinhoService cart = controller.service;
    return Scaffold(
        appBar: AppBar(
          title: Text('Carrinho'),
        ),
        body: Observer(builder: (_) {
          return Column(children: [
            Card(
              margin: EdgeInsets.all(25),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(width: 10),
                    Chip(
                      label: Text(
                        'R\$${controller.service.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    Spacer(),
                    FlatButton(
                      onPressed: () {
                        controller.criarPedido(cart);
                        cart.clear();
                        controller.service.clear();
                        setState(() {});
                      },
                      child: Text('Comprar'),
                      textColor: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Observer(builder: (_) {
                if (controller.carrinho == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (controller.carrinho!.isEmpty) {
                  return Center(
                    child: Text("Nenhum dado encontrado!!"),
                  );
                }

                return ListView.builder(
                  itemCount: controller.service.itemsCount,
                  itemBuilder: (ctx, i) {
                    var item = controller.carrinho![i];
                    return Dismissible(
                      key: ValueKey(item.id),
                      background: Container(
                        color: Theme.of(context).errorColor,
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 40,
                        ),
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20),
                        margin: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 4,
                        ),
                      ),
                      direction: DismissDirection.endToStart,
                      confirmDismiss: (_) {
                        return showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text('Tem certeza?'),
                            content: Text('Deseja remover o item do carrinho?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop(false);
                                },
                                child: Text('Não'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop(true);
                                },
                                child: Text('Sim'),
                              )
                            ],
                          ),
                        );
                      },
                      onDismissed: (_) {},
                      child: Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 4,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(9),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(item.price.toString()),
                            ),
                            title: Text(item.title),
                            subtitle: Text(
                                'Total: R\$ ${item.price * item.quantity}'),
                            trailing: Text('${item.quantity}x'),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            Center(
              child: Text('<-- Arraste para o lado para excluir um item'),
            ),
          ]);
        }));
  }
}
