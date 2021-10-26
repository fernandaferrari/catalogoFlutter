import 'package:catalogo/app/modules/gerenciarProduto/form/produto_form.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProdutoFormModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute,
            child: (_, args) => ProdutoFormulario()),
      ];
}
