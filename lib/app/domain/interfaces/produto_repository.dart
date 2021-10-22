import 'package:catalogo/app/domain/entities/produto.dart';

abstract class IProdutoRepository {
  //Método Salvar um produto
  save(Produto produto);

  //Método remover um produto através do ID
  remove(int id);

  //Método que retorna toda lista de produtos
  Future<List<Produto>> AllProdutos();
}
