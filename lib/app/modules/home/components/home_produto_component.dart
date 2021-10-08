import 'package:catalogo/app/modules/home/home_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeProdutoComponente extends StatefulWidget {
  const HomeProdutoComponente({Key? key}) : super(key: key);

  @override
  _HomeProdutoComponenteState createState() => _HomeProdutoComponenteState();
}

class _HomeProdutoComponenteState
    extends ModularState<HomeProdutoComponente, HomeStore> {
  final store = Modular.get<HomeStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (store.lista!.value == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        var produto = store.lista!.value;
        return ListView.builder(
          itemCount: produto!.length,
          itemBuilder: (ctx, i) {
            return ListTile(
              title: GestureDetector(
                  child: Text(produto[i].name, style: TextStyle(fontSize: 14))),
              leading: Image.network(produto[i].photo),
              horizontalTitleGap: double.minPositive,
              subtitle: Text('R\$' + (produto[i].price).toString()),
              trailing: CircleAvatar(
                backgroundColor: Colors.blue[100],
                child: IconButton(
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    // cart.addItem(produto);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Produto adicionado ao carrinho!'),
                        duration: Duration(seconds: 5),
                        action: SnackBarAction(
                          label: 'DESFAZER',
                          onPressed: () {
                            // cart.removeSingleItem((produto.id).toString());
                          },
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.add_shopping_cart_sharp),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
