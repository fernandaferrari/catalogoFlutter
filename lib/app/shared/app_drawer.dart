import 'package:catalogo/app/domain/entities/pedidos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Bem vindo Usuário!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Loja'),
            onTap: () {
              Modular.to.pushNamed("/");
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Pedidos Finalizados'),
            onTap: () {
              Modular.to.pushNamed("/pedidos");
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.my_library_add_sharp),
            title: Text('Gerenciar Produtos'),
            onTap: () {
              Modular.to.pushNamed("/gerenciar/");
            },
          ),
        ],
      ),
    );
  }
}
