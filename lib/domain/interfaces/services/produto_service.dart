import 'package:catalogo/domain/entities/categoria.dart';
import 'package:catalogo/domain/entities/produto.dart';

abstract class IProdutoService {
  List<Produto> get itemProduto;
  List<Categoria> get itemCategoria;
  Future<List<Produto>> loadProducts();
  Future<List<Categoria>> loadCategoria();
  List<Produto> get favoriteItems;
  List<Produto> searchItens(String text);
  List<Produto> produtoCategory({required Categoria cat});
  Future<Produto> saveProduto({required Produto produto});
  toggleFavorite(Produto produto);
  removeProduto({required int id});
}
