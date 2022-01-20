import 'package:catalogo/database/sqlite/connection.dart';
import 'package:catalogo/infra/remote_repository/remote_categoria_repository.dart';
import 'package:catalogo/infra/remote_repository/remote_produto_repository.dart';
import 'package:catalogo/infra/local_repository/local_produto_repository.dart';
import 'package:catalogo/infra/services/carrinho_service.dart';
import 'package:catalogo/infra/services/produto_service.dart';
import 'package:catalogo/pages/home/home_controller.dart';
import 'package:catalogo/pages/home/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => RemoteCategoriaRepository(client: Client())),
        Bind((i) => RemoteProdutoRepository(Client())),
        Bind((i) => Connection.instance),
        Bind((i) => LocalProdutoRepository(bd: i.get<Connection>())),
        Bind((i) => ProdutoService(
            repositoryProduto: i.get<LocalProdutoRepository>(),
            repositoryCategoria: i.get<RemoteCategoriaRepository>())),
        Bind((i) => CarrinhoService()),
        Bind((i) => HomeController(
            service: i.get<ProdutoService>(),
            cartService: i.get<CarrinhoService>())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            child: (_, args) => HomePage(), transition: TransitionType.fadeIn),
      ];
}
