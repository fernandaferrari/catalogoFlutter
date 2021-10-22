import 'package:catalogo/app/modules/home/components/app_drawer.dart';
import 'package:catalogo/app/modules/orders/components/pedidos_widget.dart';
import 'package:catalogo/app/services/pedido_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PedidosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Meus pedidos'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future:
              Provider.of<PedidoService>(context, listen: false).loadPedidos(),
          builder: (ctx, snapshot) {
            print(ctx);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.error != null) {
              return Center(
                child: Text('Ocorreu um erro'),
              );
            } else {
              return Consumer<PedidoService>(
                builder: (ctx, orders, child) => ListView.builder(
                  itemCount: orders.itemsCount,
                  itemBuilder: (ctx, i) => PedidosWidget(orders.items[i]),
                ),
              );
            }
          },
        ));
  }
}
