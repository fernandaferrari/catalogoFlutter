import 'package:catalogo/app/domain/entities/produto.dart';
import 'package:catalogo/app/services/produto_service.dart';
import 'package:mobx/mobx.dart';
part 'gerenciador_produto_controller.g.dart';

class GerenciadorProdutoController = _GerenciadorProdutoControllerBase
    with _$GerenciadorProdutoController;

abstract class _GerenciadorProdutoControllerBase with Store {
  late ProdutoService service;

  _GerenciadorProdutoControllerBase(this.service) {
    init();
  }

  @observable
  List<Produto>? itemProduto;

  @action
  Future init() async {
    itemProduto = await service.loadProducts();
  }
}
