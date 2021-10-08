import 'package:catalogo/app/dominio/repositories/produto_repository.dart';
import 'package:catalogo/app/modules/home/home_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_page.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => ProdutoRepository()),
        Bind((i) => HomeStore(i.get<ProdutoRepository>())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/home', child: (_, args) => HomePage()),
      ];
}
