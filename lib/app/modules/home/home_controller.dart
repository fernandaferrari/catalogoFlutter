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
  List<Categoria>? categoria;

  @observable
  late Produto produto;

  @action
  Future init() async {
    produtos = await service!.loadProducts();
    categoria = await service!.loadCategoria();
  }

  @computed
  int get favorite => produto.isFavorite;

  @action
  toggleIsFavorite() {
    if (produto.isFavorite == 0) {
      produto.isFavorite = 1;
    } else {
      produto.isFavorite = 0;
    }
    produto = produto.copyWith(isFavorite: produto.isFavorite);
  }

  @action
  addCarrinho(produto) {
    cartService!.addItem(produto);
  }

  @action
  removeUmItem(id) {
    cartService!.removeSingleItem(id);
  }
}
