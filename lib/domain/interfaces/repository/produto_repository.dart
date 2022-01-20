import 'package:catalogo/domain/entities/produto.dart';

abstract class ProdutoRepository {
  Future<Produto> save({required Produto produto});
  remove(int id);
  Future<List<Produto>> allProdutos();
  toggleFavorite(Produto produto);
}
