import 'package:catalogo/main/modular/carrinho_module.dart';
import 'package:catalogo/main/modular/gerenciador_produto_module.dart';
import 'package:catalogo/main/modular/home_module.dart';
import 'package:catalogo/main/modular/pedido_module.dart';
import 'package:catalogo/main/modular/produto_formulario_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(Modular.initialRoute,
            module: HomeModule(), transition: TransitionType.fadeIn),
        ModuleRoute("/gerenciar/",
            module: GerenciadorProdutoModule(),
            transition: TransitionType.rightToLeft),
        ModuleRoute("/carrinho", module: CarrinhoModule()),
        ModuleRoute("/pedidos",
            module: PedidoModule(), transition: TransitionType.fadeIn),
        ModuleRoute("/formulario",
            module: ProdutoFormularioModule(),
            transition: TransitionType.fadeIn)
      ];
}
