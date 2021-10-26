import 'package:catalogo/app/modules/orders/pedido_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:catalogo/app/domain/entities/pedidos.dart';
import 'package:catalogo/app/shared/app_drawer.dart';
import 'package:catalogo/app/services/pedido_service.dart';

class PedidosScreen extends StatefulWidget {
  final Pedido pedido;
  const PedidosScreen({
    Key? key,
    required this.pedido,
  }) : super(key: key);

  @override
  State<PedidosScreen> createState() => _PedidosScreenState();
}

class _PedidosScreenState
    extends ModularState<PedidosScreen, PedidoController> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Meus pedidos'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future: controller.pedidos,
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.error != null) {
              return Center(
                child: Text('Ocorreu um erro'),
              );
            } else {
              if (controller.pedidos == null) {
                return Center(
                  child: FloatingActionButton(
                    onPressed: () {},
                    child: Text('Tente novamente!'),
                  ),
                );
              }

              return Observer(
                builder: (_) => ListView.builder(
                    itemCount: controller.service.itemsCount,
                    itemBuilder: (ctx, i) {
                      return Card(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                  'R\$ ${widget.pedido.total!.toStringAsFixed(2)}'),
                              subtitle: Text(
                                DateFormat('dd/MM/yyyy hh:mm')
                                    .format(widget.pedido.date!),
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
                                height: widget.pedido.produtos!.length * 30.0,
                                child: ListView(
                                  children:
                                      widget.pedido.produtos!.map((produto) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                    }),
              );
            }
          },
        ));
  }
}
