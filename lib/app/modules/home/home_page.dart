import 'package:catalogo/app/modules/home/components/bolsa_widget.dart';
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

  bool showFavoriteOnly = false;
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catálogo'),
        actions: [
          Observer(
            builder: (_) => BolsaWidget(
              value: controller.cartService!.itemsCount.toString(),
              child: IconButton(
                onPressed: () {
                  Modular.to.pushNamed('/carrinho');
                },
                icon: Icon(Icons.shopping_cart),
              ),
            ),
          ),
          PopupMenuButton(
            onSelected: (selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorite) {
                  showFavoriteOnly = true;
                } else if (selectedValue == FilterOptions.All) {
                  showFavoriteOnly = false;
                  controller.produtos;
                } else if (selectedValue == FilterOptions.Category) {
                  showFavoriteOnly = false;
                }
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
              // ignore: prefer_const_constructors
              // PopupMenuItem(
              //   child: Text('Categoria'),
              //   value: FilterOptions.Category,
              //   onTap: () => showDialog(
              //     context: context,
              //     builder: (_) => ChangeNotifierProvider<ProdutoService>.value(
              //       value: categoria,
              //       child: CategoriaScreen(),
              //     ),
              //   ),
              // )
            ],
          ),
        ],
      ),
      body: Observer(
        builder: (_) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 30,
              child: Card(
                child: TextField(
                  onChanged: (value) {},
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
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
                                controller.toggleIsFavorite();
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
      ),
      drawer: AppDrawer(),
    );
  }
}
