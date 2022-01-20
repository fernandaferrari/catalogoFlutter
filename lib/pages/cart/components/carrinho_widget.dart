import 'package:flutter/material.dart';

import 'package:catalogo/domain/entities/carrinho.dart';
import 'package:catalogo/pages/cart/carrinho_controller.dart';

class CarrinhoWidget extends StatelessWidget {
  final CarrinhoItens? item;
  final CarrinhoController controller;
  const CarrinhoWidget({
    Key? key,
    this.item,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(item!.id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Tem certeza?'),
            content: const Text('Deseja remover o item do carrinho?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
                child: const Text('Não'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
                child: const Text('Sim'),
              )
            ],
          ),
        );
      },
      onDismissed: (_) {
        controller.removeCarrinho(item!.productId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: ListTile(
            leading: const CircleAvatar(
              child: Text('#Image'),
              // backgroundImage:
              //     NetworkImage(item.price.toString()),
            ),
            title: Text(item!.title),
            subtitle: Text('Total: R\$ ${item!.price * item!.quantity}'),
            trailing: Text('${item!.quantity}x'),
          ),
        ),
      ),
    );
  }
}
