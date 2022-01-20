import 'package:catalogo/domain/entities/produto.dart';
import 'package:catalogo/domain/interfaces/services/produto_service.dart';
import 'package:mobx/mobx.dart';
part 'gerenciador_produto_controller.g.dart';

class GerenciadorProdutoController = _GerenciadorProdutoControllerBase
    with _$GerenciadorProdutoController;

abstract class _GerenciadorProdutoControllerBase with Store {
  late IProdutoService service;

  _GerenciadorProdutoControllerBase({required this.service}) {
    init();
  }

  List<Produto>? itemProduto;

  @observable
  ObservableList<Produto> itemProdutos = ObservableList<Produto>();

  @action
  Future init() async {
    itemProduto = await service.loadProducts();
    itemProdutos.clear();
    for (var element in itemProduto!) {
      itemProdutos.add(element);
    }
  }

  @action
  Future<void> reloadProdutos() async {
    itemProduto = await service.loadProducts();
    itemProdutos.clear();
    for (var element in itemProduto!) {
      itemProdutos.add(element);
    }
  }

  @action
  Future<void>? excluirProduto({required int id}) {
    try {
      service.removeProduto(id: id);
    } catch (e) {
      Exception("Erro ao excluir item!");
    }
  }

  @action
  setProdutos(newValue) {
    itemProdutos.add(newValue);
  }
}
