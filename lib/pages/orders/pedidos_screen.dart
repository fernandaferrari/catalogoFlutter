import 'package:catalogo/domain/entities/pedidos.dart';
import 'package:catalogo/pages/orders/components/pedido_widget.dart';
import 'package:catalogo/pages/orders/pedido_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:catalogo/pages/drawer/app_drawer.dart';

class PedidosScreen extends StatefulWidget {
  const PedidosScreen({Key? key}) : super(key: key);

  @override
  State<PedidosScreen> createState() => _PedidosScreenState();
}

class _PedidosScreenState
    extends ModularState<PedidosScreen, PedidoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Meus pedidos'),
        ),
        drawer: const AppDrawer(),
        body: FutureBuilder<List<Pedido>>(
          future: controller.reloadPedidos(),
          builder: (ctx, snapshot) {
            if (controller.pedidos == null) {
              return Center(
                child: FloatingActionButton(
                  onPressed: () {
                    controller.reloadPedidos();
                  },
                  child: const Text('Tente novamente!'),
                ),
              );
            }

            if (controller.pedidos!.isEmpty) {
              return const Center(
                child: Text("Nenhum dado encontrado!!"),
              );
            }
            return Observer(builder: (_) {
              return ListView.builder(
                  itemCount: controller.pedidos!.length,
                  itemBuilder: (ctx, i) {
                    var item = controller.pedidos![i];
                    return PedidoWidget(item);
                  });
            });
          },
        ));
  }
}
