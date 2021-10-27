import 'package:catalogo/app/infra/repositories_impl/produto_repository_impl.dart';
import 'package:catalogo/app/modules/gerenciarProduto/form/produto_form.dart';
import 'package:catalogo/app/modules/gerenciarProduto/gerenciador_produto_controller.dart';
import 'package:catalogo/app/modules/gerenciarProduto/gerenciador_produto_page.dart';
import 'package:catalogo/app/services/produto_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class GerenciadorProdutoModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => ProdutoRepositoryImpl()),
        Bind((i) => ProdutoService(i.get<ProdutoRepositoryImpl>())),
        Bind((i) => GerenciadorProdutoController(i.get<ProdutoService>())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute("/",
            child: (_, args) => GerenciadorProdutoPage(),
            transition: TransitionType.fadeIn),
        ChildRoute("/formulario", child: (_, args) => ProdutoFormulario()),
      ];
}
