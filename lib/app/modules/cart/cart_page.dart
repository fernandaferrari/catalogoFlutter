import 'package:catalogo/app/modules/cart/components/cart_item_widget.dart';
import 'package:catalogo/app/services/carrinho_service.dart';
import 'package:catalogo/app/services/pedido_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CarrinhoService cart = Provider.of(context);
    final cartItems = cart.items.values.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
      ),
      body: Column(children: [
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
                    'R\$${cart.totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                Spacer(),
                FlatButton(
                  onPressed: () {
                    Provider.of<PedidoService>(context, listen: false)
                        .addPedido(cart);
                    cart.clear();
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
            itemCount: cart.itemsCount,
            itemBuilder: (ctx, i) => CartItemsWidget(cartItems[i]),
          ),
        ),
        Center(
          child: Text('<-- Arraste para o lado para excluir um item'),
        ),
      ]),
    );
  }
}
