import 'package:catalogo/pages/home/components/categoria_widget.dart';
import 'package:catalogo/pages/home/home_controller.dart';
import 'package:flutter/material.dart';

enum FilterOptions {
  favorite,
  all,
  category,
}

PopupMenuButton<FilterOptions> menuItens(
    {required HomeController controller, required BuildContext context}) {
  showAlertDialog(BuildContext context) {
    // set up the button
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CategoriaScreen(controller: controller);
      },
    );
  }

  return PopupMenuButton(
    key: const Key("menu"),
    onSelected: (selectedValue) {
      var value = selectedValue.toString();
      controller.filtro(value);
    },
    icon: const Icon(Icons.more_vert),
    itemBuilder: (_) => [
      // ignore: prefer_const_constructors
      PopupMenuItem(
          key: const Key("fav"),
          child: const Text('Somente Favoritos'),
          value: FilterOptions.favorite),
      // ignore: prefer_const_constructors
      PopupMenuItem(
        key: const Key("all"),
        child: const Text('Todos'),
        value: FilterOptions.all,
      ),
      PopupMenuItem(
        key: const Key("cat"),
        value: FilterOptions.category,
        child: TextButton(
            onPressed: () => showAlertDialog(context),
            child: const Text(
              'Categoria',
              style: TextStyle(fontSize: 16),
            )),
      )
    ],
  );
}
