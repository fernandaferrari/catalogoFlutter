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

  @action
  categoria() {
    var item = service.itemCategoria;
    List<String> cat = [];

    item.forEach((element) {
      cat = ['${element.id}'];
    });

    cat = List.generate(item.length, (i) {
      var resultado = item[i];
      return Categoria(id: resultado.id, name: resultado.name).toString();
    });

    return cat;
  }
}
