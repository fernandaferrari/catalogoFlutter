import 'package:catalogo/app/modules/orders/components/pedido_widget.dart';
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
  @override
  State<PedidosScreen> createState() => _PedidosScreenState();
}

class _PedidosScreenState
    extends ModularState<PedidosScreen, PedidoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus pedidos'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: controller.service.loadPedidos(),
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

            if (controller.pedidos!.isEmpty) {
              return Center(
                child: Text("Nenhum dado encontrado!!"),
              );
            }

            return Observer(
              builder: (_) => ListView.builder(
                  itemCount: controller.pedidos!.length,
                  itemBuilder: (ctx, i) {
                    var item = controller.pedidos![i];
                    return PedidoWidget(item);
                  }),
            );
          }
        },
      ),
    );
  }
}
