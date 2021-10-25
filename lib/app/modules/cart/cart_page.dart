import 'package:catalogo/app/domain/entities/pedidos.dart';
import 'package:catalogo/app/modules/cart/carrinho_controller.dart';
import 'package:catalogo/app/modules/cart/components/cart_item_widget.dart';
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
                        // controller.pedidoService.addPedido(controller.carrinho,
                        //     controller.service.totalAmount);
                        controller.criarPedido();
                        controller.carrinho!.clear();
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
              child: ListView.builder(
                itemCount: controller.service.itemsCount,
                itemBuilder: (ctx, i) {
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

                  return CartItemsWidget(controller.carrinho![i]);
                },
              ),
            ),
            Center(
              child: Text('<-- Arraste para o lado para excluir um item'),
            ),
          ]);
        }));
  }
}
