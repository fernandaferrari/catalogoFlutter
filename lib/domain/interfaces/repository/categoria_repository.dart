import 'package:catalogo/domain/entities/categoria.dart';

abstract class CategoriaRepository {
  Future<List<Categoria>> allCategoria();
}
