import 'package:catalogo/app/domain/entities/produto.dart';
import 'package:catalogo/app/infra/api_repository/api_categoria_repository.dart';
import 'package:catalogo/app/infra/api_repository/api_produto_repository.dart';
import 'package:catalogo/app/infra/database/sqlite/connection.dart';
import 'package:catalogo/app/infra/repositories_impl/carrinho_repository_impl.dart';
import 'package:catalogo/app/infra/repositories_impl/produto_repository_impl.dart';
import 'package:catalogo/app/modules/home/components/categoria/categoria_screen.dart';
import 'package:catalogo/app/modules/home/home_controller.dart';
import 'package:catalogo/app/modules/home/home_page.dart';
import 'package:catalogo/app/services/carrinho_service.dart';
import 'package:catalogo/app/services/produto_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => ApiCategoriaRepository(Client())),
        Bind((i) => ApiProdutoRepository(Client())),
        Bind((i) => Connection(
            i.get<ApiProdutoRepository>(), i.get<ApiCategoriaRepository>())),
        Bind((i) => ProdutoRepositoryImpl()),
        Bind((i) => ProdutoService(i.get<ProdutoRepositoryImpl>())),
        Bind((i) =>
            HomeController(i.get<ProdutoService>(), i.get<CarrinhoService>())),
        Bind((i) => CarrinhoRepository()),
        Bind((i) => CarrinhoService()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            child: (_, args) => HomePage(), transition: TransitionType.fadeIn),
        ChildRoute('/categoria', child: (_, args) => CategoriaScreen(_)),
      ];
}
