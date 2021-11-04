import 'package:catalogo/app/domain/entities/carrinho.dart';
import 'package:catalogo/app/domain/entities/categoria.dart';
import 'package:catalogo/app/services/carrinho_service.dart';
import 'package:mobx/mobx.dart';

import 'package:catalogo/app/domain/entities/produto.dart';
import 'package:catalogo/app/services/produto_service.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  late ProdutoService? service;

  late CarrinhoService? cartService;

  _HomeControllerBase(
    this.service,
    this.cartService,
  ) {
    init();
  }

  @observable
  List<Produto>? produtos;

  @observable
  List<Categoria>? categoria = [];

  @observable
  Map<String, CarrinhoItens>? cart = {};

  @action
  Future init() async {
    produtos = await service!.loadProducts();
    categoria = await service!.loadCategoria();
  }

  @action
  toggleIsFavorite(item) {
    if (item.isFavorite == 0) {
      item.isFavorite = 1;
    } else {
      item.isFavorite = 0;
    }
    service!.repositoryProduto.toggleFavorite(item);
  }

  @action
  buscaNome(text) {
    produtos = service!.searchItens(text);
  }

  @action
  setProduto() {
    produtos = service!.itemProdutoAll;
  }

  @action
  teste(value) {
    if (value == "FilterOptions.All") {
      produtos = service!.itemProdutoAll;
    }
    if (value == "FilterOptions.Favorite") {
      produtos = service!.favoriteItems;
    }
    if (value == "FilterOptions.Category") {}
  }

  @action
  addCarrinho(produto) {
    cartService!.addItem(produto);
    cart = cartService!.items;
  }

  @action
  removeUmItem(id) {
    cartService!.removeSingleItem(id);
  }

  @action
  buscarCategoria(cat) {
    produtos = service!.produtoCategory(cat);
  }
}
