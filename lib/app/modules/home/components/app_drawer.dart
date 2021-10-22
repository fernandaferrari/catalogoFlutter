import 'package:catalogo/app/utils/app_routes.dart';
import 'package:flutter/material.dart';

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
              Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Pedidos Finalizados'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.PEDIDOS);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.my_library_add_sharp),
            title: Text('Gerenciar Produtos'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.GERENCIAR);
            },
          ),
        ],
      ),
    );
  }
}
