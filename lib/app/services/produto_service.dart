import 'dart:convert';
import 'dart:math';

import 'package:catalogo/app/infra/api_repository/api_categoria_repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'package:catalogo/app/domain/entities/categoria.dart';
import 'package:catalogo/app/domain/entities/produto.dart';
import 'package:catalogo/app/infra/repositories_impl/produto_repository_impl.dart';

class ProdutoService with ChangeNotifier {
  //Inicia váriaveis repository
  late ProdutoRepositoryImpl repositoryProduto;
  final repositoryCategoria = ApiCategoriaRepository(Client());

  //Inicia váriaveis itens lista
  List<Categoria> _itemCategoria = [];
  List<Produto> _itensProduto = [];
  ProdutoService(this.repositoryProduto);

  //Variavel list sempre com todos os produtos
  List<Produto> _itemAll = [];
  List<Produto> get itemProdutoAll => [..._itemAll];

  //getter e setter Produto
  List<Produto> get itemProduto => [..._itensProduto];
  setItensProduto(newItens) {
    _itensProduto = newItens;
    notifyListeners();
  }

  //getter e setter Categoria
  List<Categoria> get itemCategoria => _itemCategoria;
  setItensCategoria(newItens) => _itemCategoria = newItens;

  int get itensCount => itemProduto.length;

  List<String> get teste => itemCategoria.map((e) => e.id.toString()).toList();

  Future<List<Produto>> loadProducts() async {
    _itemAll = await repositoryProduto.AllProdutos();
    return _itensProduto = await repositoryProduto.AllProdutos();
  }

  Future<List<Categoria>> loadCategoria() async {
    return _itemCategoria = await repositoryCategoria.AllCategoria();
  }

  //filtro favoritos
  List<Produto> get favoriteItems =>
      itemProduto.where((prod) => prod.isFavorite == 1).toList();

  //busca por nome
  List<Produto> searchItens(String text) {
    if (text == "") {
      return _itemAll;
    } else {
      List<Produto> _teste = _itensProduto.where((item) {
        final titleLower = item.name!.toLowerCase();
        final searchLower = text.toLowerCase();
        return titleLower.contains(searchLower);
      }).toList();
      setItensProduto(_teste);
      return _itensProduto;
    }
  }

  //busca por categoria
  produtoCategory(Categoria cat) {
    List<Produto> _produto =
        _itensProduto.where((item) => item.categoryId == cat.id).toList();
    setItensProduto(_produto);
    notifyListeners();
  }

  removeProduto(Produto produto) {
    repositoryProduto.remove(produto.id!);
  }
}
