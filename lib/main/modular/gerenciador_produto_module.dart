import 'package:catalogo/database/sqlite/connection.dart';
import 'package:catalogo/infra/remote_repository/remote_categoria_repository.dart';
import 'package:catalogo/infra/local_repository/local_produto_repository.dart';
import 'package:catalogo/infra/services/produto_service.dart';
import 'package:catalogo/pages/gerenciarProduto/gerenciador_produto_controller.dart';
import 'package:catalogo/pages/gerenciarProduto/gerenciador_produto_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class GerenciadorProdutoModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => LocalProdutoRepository(bd: i.get<Connection>())),
        Bind((i) => ProdutoService(
            repositoryProduto: i.get<LocalProdutoRepository>(),
            repositoryCategoria: i.get<RemoteCategoriaRepository>())),
        Bind((i) =>
            GerenciadorProdutoController(service: i.get<ProdutoService>())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (_, args) => const GerenciadorProdutoPage(),
        ),
      ];
}
