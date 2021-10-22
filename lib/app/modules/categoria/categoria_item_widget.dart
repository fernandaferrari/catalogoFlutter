import 'package:catalogo/app/domain/entities/categoria.dart';
import 'package:catalogo/app/infra/repositories_impl/categoria_repository_impl.dart';
import 'package:catalogo/app/services/produto_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriaItemWidget extends StatefulWidget {
  @override
  State<CategoriaItemWidget> createState() => _CategoriaItemWidgetState();
}

class _CategoriaItemWidgetState extends State<CategoriaItemWidget> {
  final repository = CategoriaRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    final Categoria categoria = Provider.of<Categoria>(context, listen: false);
    final cat = Provider.of<ProdutoService>(context, listen: false);

    return ListTile(
      title: GestureDetector(
        onTap: () {
          cat.produtoCategory(categoria);
          Navigator.pop(context);
        },
        child: Text(
          categoria.name,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}