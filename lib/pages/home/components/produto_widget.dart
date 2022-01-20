import 'package:flutter/material.dart';

import 'package:catalogo/domain/entities/produto.dart';
import 'package:catalogo/pages/home/home_controller.dart';

class ProdutoWidget extends StatefulWidget {
  final Produto? item;
  final HomeController controller;

  const ProdutoWidget({
    Key? key,
    this.item,
    required this.controller,
  }) : super(key: key);

  @override
  _ProdutoWidgetState createState() => _ProdutoWidgetState();
}

class _ProdutoWidgetState extends State<ProdutoWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        child: Card(
      elevation: 3,
      child: Row(children: [
        Expanded(
          child: ListTile(
            title: GestureDetector(
                child: Text(widget.item!.name!,
                    style: const TextStyle(fontSize: 14))),
            leading: Image.network(widget.item!.photo!),
            horizontalTitleGap: double.minPositive,
            subtitle: Text('R\$' + (widget.item!.price).toString()),
            trailing: CircleAvatar(
              backgroundColor: Colors.blue[100],
              child: IconButton(
                key: const Key("remove"),
                color: Theme.of(context).colorScheme.secondary,
                onPressed: () {
                  widget.controller.addCarrinho(widget.item);

                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Produto adicionado ao carrinho!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                icon: const Icon(Icons.add_shopping_cart_sharp),
              ),
            ),
          ),
        ),
        IconButton(
          key: const Key("favorite"),
          icon: Icon(
              widget.item!.isFavorite == 1 ? Icons.star : Icons.star_border),
          onPressed: () {
            widget.controller.toggleIsFavorite(widget.item);
            setState(() {});
          },
        )
      ]),
    ));
  }
}
