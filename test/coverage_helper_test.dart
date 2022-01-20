// ignore_for_file: unused_import
import 'package:catalogo/domain/interfaces/repository/categoria_repository.dart';
import 'package:catalogo/main/main.dart';
import 'package:catalogo/domain/entities/categoria.dart';
import 'package:catalogo/domain/entities/carrinho.dart';
import 'package:catalogo/domain/entities/pedidos.dart';
import 'package:catalogo/domain/entities/produto.dart';
import 'package:catalogo/domain/interfaces/repository/produto_repository.dart';
import 'package:catalogo/domain/interfaces/repository/pedido_repository.dart';
import 'package:catalogo/pages/gerenciarProduto/gerenciador_produto_controller.dart';
import 'package:catalogo/pages/gerenciarProduto/gerenciador_produto_page.dart';
import 'package:catalogo/pages/formulario/produto_form_page.dart';
import 'package:catalogo/main/modular/gerenciador_produto_module.dart';
import 'package:catalogo/pages/orders/components/pedido_widget.dart';
import 'package:catalogo/pages/orders/pedidos_screen.dart';
import 'package:catalogo/main/modular/pedido_module.dart';
import 'package:catalogo/pages/orders/pedido_controller.dart';
import 'package:catalogo/pages/home/components/categoria_widget.dart';
import 'package:catalogo/pages/home/components/produto_widget.dart';
import 'package:catalogo/pages/home/components/bolsa_widget.dart';
import 'package:catalogo/main/modular/home_module.dart';
import 'package:catalogo/pages/home/home_controller.dart';
import 'package:catalogo/pages/home/home_page.dart';
import 'package:catalogo/pages/cart/carrinho_controller.dart';
import 'package:catalogo/pages/cart/cart_page.dart';
import 'package:catalogo/pages/cart/components/carrinho_widget.dart';
import 'package:catalogo/main/modular/carrinho_module.dart';
import 'package:catalogo/infra/services/pedido_service.dart';
import 'package:catalogo/infra/services/carrinho_service.dart';
import 'package:catalogo/infra/services/produto_service.dart';
import 'package:catalogo/pages/drawer/app_drawer.dart';
import 'package:catalogo/infra/local_repository/local_produto_repository.dart';
import 'package:catalogo/infra/remote_repository/remote_categoria_repository.dart';
import 'package:catalogo/infra/remote_repository/remote_pedido_repository.dart';
import 'package:catalogo/infra/remote_repository/remote_produto_repository.dart';
import 'package:catalogo/infra/utils/err/http_exception.dart';

void main() {}
