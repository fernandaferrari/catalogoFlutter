import 'package:catalogo/app/domain/entities/categoria.dart';
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

  @observable
  List<Categoria>? itemCategoria;

  @action
  Future init() async {
    itemProduto = await service.loadProducts();
    itemCategoria = await service.loadCategoria();
  }

  buscaCategoria(item) {
    String teste = item;
    var result = teste.substring(0, 1);
    return result;
  }

  @action
  reloadProdutos() async {
    itemProduto = await service.loadProducts();
  }

  @action
  categoria() {
    var item = service.itemCategoria;
    List<String> cat = [];
    cat = List.generate(item.length, (i) {
      var resultado = item[i];
      return Categoria(id: resultado.id, name: resultado.name).toString();
    });

    return cat;
  }

  @action
  excluirProduto(id) {
    service.repositoryProduto.remove(id);
    reloadProdutos();
  }
}
