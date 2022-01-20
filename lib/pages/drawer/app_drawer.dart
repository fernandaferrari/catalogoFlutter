import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Bem vindo Usuário!'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            key: const Key("loja"),
            leading: const Icon(Icons.shop),
            title: const Text('Loja'),
            onTap: () {
              Modular.to.pushNamed('/');
            },
          ),
          const Divider(),
          ListTile(
            key: const Key("pedido"),
            leading: const Icon(Icons.payment),
            title: const Text('Pedidos Finalizados'),
            onTap: () {
              Modular.to.pushNamed("/pedidos/");
            },
          ),
          const Divider(),
          ListTile(
            key: const Key("gerenciar"),
            leading: const Icon(Icons.my_library_add_sharp),
            title: const Text('Gerenciar Produtos'),
            onTap: () {
              Modular.to.popAndPushNamed("/gerenciar/");
            },
          ),
        ],
      ),
    );
  }
}
