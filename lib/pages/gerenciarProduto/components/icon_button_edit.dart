import 'package:catalogo/domain/entities/produto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class IconButtonEdit extends StatelessWidget {
  const IconButtonEdit({
    Key? key,
    required this.produto,
  }) : super(key: key);

  final Produto produto;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: const Key("edit"),
      icon: const Icon(Icons.edit),
      color: Theme.of(context).primaryColor,
      onPressed: () async {
        Modular.to.pushNamed("/formulario/", arguments: produto);
      },
    );
  }
}
