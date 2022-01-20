import 'package:catalogo/domain/entities/carrinho.dart';
import 'package:catalogo/pages/cart/components/carrinho_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:catalogo/pages/cart/carrinho_controller.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ModularState<CartPage, CarrinhoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: Column(children: [
        Card(
          margin: const EdgeInsets.all(25),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 10),
                Chip(
                  label: Observer(
                      name: 'total',
                      builder: (_) {
                        return Text(
                          'R\$${controller.total!.toStringAsFixed(2)}',
                          style: const TextStyle(color: Colors.white),
                        );
                      }),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                const Spacer(),
                Observer(builder: (_) {
                  return TextButton(
                    onPressed: controller.carrinho!.isEmpty
                        ? null
                        : () {
                            List<CarrinhoItens> cart = controller.carrinho!;
                            double total = controller.total!;
                            controller.criarPedido(cart, total);
                            controller.itensClear();
                            setState(() {});
                          },
                    child: const Text('Comprar'),
                    style: TextButton.styleFrom(
                        primary: Theme.of(context).primaryColor),
                  );
                })
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: Observer(
              name: 'lista',
              builder: (_) {
                return ListView.builder(
                  itemCount: controller.carrinho!.length,
                  itemBuilder: (ctx, i) {
                    var item = controller.carrinho![i];
                    return CarrinhoWidget(item: item, controller: controller);
                  },
                );
              }),
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.arrow_back),
              Text('Arraste para o lado para excluir um item',
                  style: TextStyle(fontSize: 15)),
            ],
          ),
        ),
      ]),
    );
  }
}
