import 'package:catalogo/domain/entities/carrinho.dart';
import 'package:catalogo/domain/entities/categoria.dart';
import 'package:catalogo/domain/interfaces/services/carrinho_service.dart';
import 'package:catalogo/domain/interfaces/services/produto_service.dart';
import 'package:mobx/mobx.dart';

import 'package:catalogo/domain/entities/produto.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  late IProdutoService? service;
  late ICarrinhoService? cartService;

  _HomeControllerBase({
    this.service,
    this.cartService,
  }) {
    init();
  }

  @observable
  List<Produto>? produtos = [];

  @observable
  List<Categoria>? categoria = [];

  @observable
  Map<String, CarrinhoItens>? cart = {};

  @action
  Future init() async {
    produtos = await service!.loadProducts();
    categoria = await service!.loadCategoria();
    cart = cartService!.items;
  }

  @action
  toggleIsFavorite(item) {
    if (item.isFavorite == 0) {
      item.isFavorite = 1;
    } else {
      item.isFavorite = 0;
    }
    service!.toggleFavorite(item);
  }

  @action
  Future<void> loadProdutos() async {
    produtos = await service!.loadProducts();
  }

  @action
  loadCart() async {
    cart = cartService!.items;
  }

  @action
  buscaNome(text) {
    produtos = service!.searchItens(text);
  }

  @action
  filtro(value) {
    if (value == "FilterOptions.all") {
      produtos = service!.itemProduto;
    }
    if (value == "FilterOptions.favorite") {
      produtos = service!.favoriteItems;
    }
  }

  void addCarrinho(produto) {
    cartService!.addItem(produto);
    loadCart();
  }

  void removeUmItem(id) {
    cartService!.removeSingleItem(id);
    loadCart();
  }

  @action
  buscarCategoria(cat) {
    produtos = service!.produtoCategory(cat: cat);
  }
}
