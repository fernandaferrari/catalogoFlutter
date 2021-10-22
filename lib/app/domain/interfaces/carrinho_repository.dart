import 'package:catalogo/app/domain/entities/carrinho.dart';

abstract class ICarrinhoRepository {
  save(CarrinhoItens carrinho);
  remove(int id);
  Future<List<CarrinhoItens>> AllCarrinho();
}
