import 'package:catalogo/domain/entities/produto.dart';
import 'package:catalogo/pages/gerenciarProduto/gerenciador_produto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class IconButtonDelete extends StatelessWidget {
  const IconButtonDelete({
    Key? key,
    required this.controller,
    required this.produto,
  }) : super(key: key);

  final GerenciadorProdutoController controller;
  final Produto produto;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: const Key("excluir"),
      icon: const Icon(Icons.delete),
      color: Theme.of(context).errorColor,
      onPressed: () {
        showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Excluir Produto'),
            content: const Text('Tem certeza?'),
            actions: [
              TextButton(
                child: const Text('Não'),
                onPressed: () => Modular.to.pop(false),
              ),
              TextButton(
                child: const Text('Sim'),
                onPressed: () async {
                  try {
                    controller.excluirProduto(id: produto.id!);
                    await controller.reloadProdutos();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.toString()),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }

                  Modular.to.pop(true);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
