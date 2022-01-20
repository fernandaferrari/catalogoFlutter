import 'package:catalogo/domain/entities/categoria.dart';
import 'package:flutter/foundation.dart';

class Produto with ChangeNotifier {
  int? id;
  String? name;
  String? description;
  String? photo;
  num? price;
  int? categoryId;
  late int isFavorite;
  List<Categoria>? categorias = [];

  Produto(
      {this.id,
      this.name,
      this.description,
      this.photo,
      this.price,
      this.categoryId,
      this.isFavorite = 0});
}
