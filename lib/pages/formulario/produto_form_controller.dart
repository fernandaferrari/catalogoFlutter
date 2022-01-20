import 'package:catalogo/domain/entities/categoria.dart';
import 'package:catalogo/domain/entities/produto.dart';
import 'package:catalogo/domain/helpers/domain_error.dart';
import 'package:catalogo/domain/interfaces/services/produto_service.dart';
import 'package:catalogo/pages/gerenciarProduto/gerenciador_produto_controller.dart';
import 'package:mobx/mobx.dart';
part 'produto_form_controller.g.dart';

class ProdutoFormController = _ProdutoFormControllerBase
    with _$ProdutoFormController;

abstract class _ProdutoFormControllerBase with Store {
  late IProdutoService service;
  late GerenciadorProdutoController gerenciarController;

  _ProdutoFormControllerBase(
      {required this.service, required this.gerenciarController}) {
    init();
  }

  init() async {
    itemCategoria = await service.loadCategoria();
  }

  @observable
  List<Categoria>? itemCategoria;

  buscaCategoria(item) {
    String result = item.substring(0, 1);
    return result;
  }

  List<String>? categoria() {
    var item = service.itemCategoria;
    if (item.isNotEmpty) {
      List<String> cat = List.generate(item.length, (i) {
        var resultado = item[i];
        return Categoria(id: resultado.id, name: resultado.name).toString();
      });
      return cat;
    } else {
      return ["Erro tente novamente"];
    }
  }

  save({required Produto produto}) async {
    try {
      var produt = await service.saveProduto(produto: produto);
      gerenciarController.setProdutos(produt);
    } on DomainError {
      return throw DomainError.unexpected;
    }
  }
}
