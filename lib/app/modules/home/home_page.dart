import 'package:catalogo/app/modules/home/components/bolsa_widget.dart';
import 'package:catalogo/app/modules/home/components/categoria/categoria_screen.dart';
import 'package:catalogo/app/modules/home/home_controller.dart';
import 'package:catalogo/app/services/carrinho_service.dart';
import 'package:catalogo/app/services/produto_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../shared/app_drawer.dart';

enum FilterOptions {
  Favorite,
  All,
  Category,
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    showAlertDialog(BuildContext context) {
      // set up the button
      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {},
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CategoriaScreen(context);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Catálogo'),
        actions: [
          Observer(builder: (_) {
            if (controller.cart == null) {
              return Center(child: CircularProgressIndicator());
            }
            return BolsaWidget(
              value: '${controller.cart!.length}',
              child: IconButton(
                onPressed: () {
                  Modular.to.pushNamed('/carrinho');
                },
                icon: Icon(Icons.shopping_cart),
              ),
            );
          }),
          PopupMenuButton(
            onSelected: (selectedValue) {
              setState(() {
                var value = selectedValue.toString();
                controller.teste(value);
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              // ignore: prefer_const_constructors
              PopupMenuItem(
                  child: Text('Somente Favoritos'),
                  value: FilterOptions.Favorite),
              // ignore: prefer_const_constructors
              PopupMenuItem(
                child: Text('Todos'),
                value: FilterOptions.All,
              ),
              PopupMenuItem(
                value: FilterOptions.Category,
                child: TextButton(
                    onPressed: () => showAlertDialog(context),
                    child: Text(
                      'Categoria',
                      style: TextStyle(fontSize: 16),
                    )),
                // onTap: () => showDialog(
                //     context: context,
                //     builder: (_) => CategoriaScreen(context)))
              )
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 30,
            child: Card(
              child: TextField(
                onChanged: (value) {
                  controller.buscaNome(value);
                },
                decoration: InputDecoration(
                  labelText: 'Buscar por nome de produto',
                  suffixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          Container(
            child: Expanded(
              child: Observer(
                builder: (_) {
                  if (controller.produtos == null) {
                    return Center(
                      child: FloatingActionButton(
                        onPressed: () {},
                        child: Text('Tente novamente!'),
                      ),
                    );
                  }

                  if (controller.produtos!.isEmpty) {
                    return Center(
                      child: Text("Nenhum dado encontrado!!"),
                    );
                  }

                  return ListView.builder(
                    itemCount: controller.produtos!.length,
                    itemBuilder: (context, index) {
                      var item = controller.produtos![index];

                      return ClipRRect(
                          child: Card(
                        elevation: 3,
                        child: Row(children: [
                          Expanded(
                            child: ListTile(
                              title: GestureDetector(
                                  child: Text(item.name!,
                                      style: TextStyle(fontSize: 14))),
                              leading: Image.network(item.photo!),
                              horizontalTitleGap: double.minPositive,
                              subtitle: Text('R\$' + (item.price).toString()),
                              trailing: CircleAvatar(
                                backgroundColor: Colors.blue[100],
                                child: IconButton(
                                  color: Theme.of(context).accentColor,
                                  onPressed: () {
                                    controller.addCarrinho(item);
                                    // cart.addItem(produto);
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Produto adicionado ao carrinho!'),
                                        duration: Duration(seconds: 5),
                                        action: SnackBarAction(
                                          label: 'DESFAZER',
                                          onPressed: () {
                                            controller.removeUmItem(
                                                (item.id).toString());
                                          },
                                        ),
                                      ),
                                    );
                                    setState(() {});
                                  },
                                  icon: Icon(Icons.add_shopping_cart_sharp),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(item.isFavorite == 1
                                ? Icons.star
                                : Icons.star_border),
                            onPressed: () {
                              controller.toggleIsFavorite(item);
                              setState(() {});
                            },
                          )
                        ]),
                      ));
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
    );
  }
}
