import 'package:catalogo/database/sqlite/connection.dart';
import 'package:catalogo/infra/remote_repository/remote_categoria_repository.dart';
import 'package:catalogo/infra/local_repository/local_produto_repository.dart';
import 'package:catalogo/infra/services/produto_service.dart';
import 'package:catalogo/pages/formulario/produto_form_controller.dart';
import 'package:catalogo/pages/formulario/produto_form_page.dart';
import 'package:catalogo/pages/gerenciarProduto/gerenciador_produto_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';

class ProdutoFormularioModule extends Module {
  @override
  List<Bind> get binds => [
        //injeção dependencia ProdutoService
        Bind((i) => RemoteCategoriaRepository(client: Client())),
        Bind((i) => LocalProdutoRepository(bd: Connection.instance)),
        Bind((i) => ProdutoService(
            repositoryProduto: i.get<LocalProdutoRepository>(),
            repositoryCategoria: i.get<RemoteCategoriaRepository>())),

        //injeção dependencia GerenciadorController
        Bind((i) =>
            GerenciadorProdutoController(service: i.get<ProdutoService>())),

        Bind((i) => ProdutoFormController(
            service: i.get<ProdutoService>(),
            gerenciarController: i.get<GerenciadorProdutoController>()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute,
            child: (_, args) => ProdutoFormulario(
                  produto: args.data,
                ))
      ];
}
