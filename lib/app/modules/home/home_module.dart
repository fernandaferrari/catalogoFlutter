import 'package:catalogo/app/infra/api_repository/api_produto_repository.dart';
import 'package:catalogo/app/infra/database/sqlite/connection.dart';
import 'package:catalogo/app/infra/repositories_impl/produto_repository_impl.dart';
import 'package:catalogo/app/modules/home/home_controller.dart';
import 'package:catalogo/app/modules/home/home_page.dart';
import 'package:catalogo/app/services/produto_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => ApiProdutoRepository(Client())),
        Bind((i) => Connection(i.get<ApiProdutoRepository>())),
        Bind((i) => ProdutoRepositoryImpl()),
        Bind((i) => ProdutoService(i.get<ProdutoRepositoryImpl>())),
        Bind((i) => HomeController(i.get<ProdutoService>())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute,
            child: (_, args) => HomePage(), transition: TransitionType.fadeIn),
      ];
}
