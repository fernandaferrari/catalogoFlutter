import 'package:catalogo/app/domain/entities/categoria.dart';
import 'package:catalogo/app/infra/api_repository/api_categoria_repository.dart';
import 'package:catalogo/app/infra/api_repository/api_produto_repository.dart';
import 'package:catalogo/app/modules/categoria/categoria_item_widget.dart';
import 'package:catalogo/app/services/produto_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class CategoriaScreen extends StatefulWidget {
  @override
  State<CategoriaScreen> createState() => _CategoriaScreenState();
}

class _CategoriaScreenState extends State<CategoriaScreen> {
  final repository = ApiCategoriaRepository(Client());
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    repository.AllCategoria();
  }

  @override
  Widget build(BuildContext context) {
    ProdutoService categoria =
        Provider.of<ProdutoService>(context, listen: false);
    List<Categoria> list = categoria.itemCategoria;

    return AlertDialog(
      title: const Text('Filtro por Categoria'),
      content: Container(
        height: 290,
        width: 290,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) => ChangeNotifierProvider.value(
            value: list[index],
            child: CategoriaItemWidget(),
          ),
        ),
      ),
    );
  }
}
