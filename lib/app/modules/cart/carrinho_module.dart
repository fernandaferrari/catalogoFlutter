import 'package:catalogo/app/infra/repositories_impl/carrinho_repository_impl.dart';
import 'package:catalogo/app/modules/cart/cart_page.dart';
import 'package:catalogo/app/services/carrinho_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CarrinhoModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => CarrinhoRepository()),
        Bind((i) => CarrinhoService()),
      ];

  @override
  List<ModularRoute> get routes =>
      [ChildRoute('/carrinho', child: (_, args) => CartPage())];
}
