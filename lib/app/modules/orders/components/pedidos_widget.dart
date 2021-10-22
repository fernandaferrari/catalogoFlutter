import 'package:catalogo/app/domain/entities/pedidos.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PedidosWidget extends StatefulWidget {
  final Pedido pedido;

  PedidosWidget(this.pedido);

  @override
  State<PedidosWidget> createState() => _PedidosWidgetState();
}

class _PedidosWidgetState extends State<PedidosWidget> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('R\$ ${widget.pedido.total.toStringAsFixed(2)}'),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.pedido.date),
            ),
            trailing: IconButton(
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                icon: Icon(Icons.expand_more)),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 4,
              ),
              height: widget.pedido.produtos.length * 30.0,
              child: ListView(
                children: widget.pedido.produtos.map((produto) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          produto.name,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        '${produto.quantity}x  R\$ ${produto.price}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
