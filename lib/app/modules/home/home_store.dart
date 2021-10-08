import 'package:catalogo/app/dominio/models/produto.dart';
import 'package:catalogo/app/dominio/repositories/produto_repository.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final ProdutoRepository repository;

  @observable
  ObservableFuture<List<Produto>>? lista;

  HomeStoreBase(this.repository) {
    fetchProdutos();
  }

  @action
  fetchProdutos() {
    lista = repository.fetchProdutos().asObservable();
  }
}
