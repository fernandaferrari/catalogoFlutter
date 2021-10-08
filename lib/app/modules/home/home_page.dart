import 'package:catalogo/app/modules/home/components/home_produto_component.dart';
import 'package:catalogo/app/modules/home/home_store.dart';
import 'package:catalogo/app/shared/app_widget/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Catalogo')),
      drawer: AppDrawer(),
      body: HomeProdutoComponente(),
    );
  }
}

  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Catalogo'),
  //     ),
  //     body: Observer(
  //       builder: (_) {
  //         var produto = store.lista!.value;
  //         return ListView.builder(
  //           itemCount: produto!.length,
  //           itemBuilder: (ctx, i) {
  //             return ListTile(
  //               title: Text(produto[i].name),
  //             );
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }