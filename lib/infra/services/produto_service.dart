import 'package:catalogo/domain/entities/categoria.dart';
import 'package:catalogo/domain/entities/produto.dart';
import 'package:catalogo/domain/interfaces/repository/categoria_repository.dart';
import 'package:catalogo/domain/interfaces/repository/produto_repository.dart';
import 'package:catalogo/domain/interfaces/services/produto_service.dart';

class ProdutoService implements IProdutoService {
  final ProdutoRepository repositoryProduto;
  final CategoriaRepository repositoryCategoria;
  List<Categoria> _itemCategoria = [];
  List<Produto> _itensProduto = [];

  ProdutoService({
    required this.repositoryProduto,
    required this.repositoryCategoria,
  });

  @override
  List<Produto> get itemProduto => [..._itensProduto];
  setItensProduto(newItens) {
    _itensProduto = newItens;
  }

  @override
  List<Categoria> get itemCategoria => _itemCategoria;
  setItensCategoria(newItens) => _itemCategoria = newItens;

  @override
  Future<List<Produto>> loadProducts() async {
    return _itensProduto = await repositoryProduto.allProdutos();
  }

  @override
  Future<List<Categoria>> loadCategoria() async {
    return _itemCategoria = await repositoryCategoria.allCategoria();
  }

  @override
  List<Produto> get favoriteItems =>
      itemProduto.where((prod) => prod.isFavorite == 1).toList();

  @override
  List<Produto> searchItens(String text) {
    if (text == "") {
      return _itensProduto;
    } else {
      List<Produto> _teste = _itensProduto.where((item) {
        final titleLower = item.name!.toLowerCase();
        final searchLower = text.toLowerCase();
        return titleLower.contains(searchLower);
      }).toList();
      return _teste;
    }
  }

  @override
  List<Produto> produtoCategory({required Categoria cat}) {
    List<Produto> result =
        _itensProduto.where((item) => item.categoryId == cat.id).toList();
    return result;
  }

  @override
  Future<Produto> saveProduto({required Produto produto}) async {
    var item = await repositoryProduto.save(produto: produto);
    var produtos = await loadProducts();
    setItensProduto(produtos);

    return item;
  }

  @override
  toggleFavorite(Produto produto) async {
    await repositoryProduto.toggleFavorite(produto);
  }

  @override
  removeProduto({required int id}) async {
    await repositoryProduto.remove(id);
  }
}
