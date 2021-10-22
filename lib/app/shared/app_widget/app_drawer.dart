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
              //Modular.to.navigate("/home", arguments: HomePage());
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Pedidos Finalizados'),
            // onTap: () {
            //   Navigator.of(context).pushReplacementNamed(AppRoutes.PEDIDOS);
            // },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.my_library_add_rounded),
            title: Text('Cadastro de Produto'),
            onTap: () {
              //Modular.to.navigate("/cadastro", arguments: ProdutoPage());
            },
          ),
        ],
      ),
    );
  }
}
