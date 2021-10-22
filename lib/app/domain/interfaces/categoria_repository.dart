import 'package:catalogo/app/domain/entities/categoria.dart';

abstract class ICategoriaRepository {
  //Retorna lista de todas as Categorias
  Future<List<Categoria>> AllCategorias();
}
