import 'dart:convert';
import 'package:catalogo/app/domain/entities/categoria.dart';
import 'package:catalogo/app/utils/json/constants.dart';
import 'package:http/http.dart' as http;
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

  copyWith(
      {int? id,
      String? name,
      String? description,
      String? photo,
      num? price,
      int? categoryId,
      int? isFavorite}) {
    return Produto(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        photo: photo ?? this.photo,
        price: price ?? this.price,
        categoryId: categoryId ?? this.categoryId,
        isFavorite: isFavorite ?? this.isFavorite);
  }

  void toggleFavorite() {
    if (isFavorite == 0) {
      isFavorite = 1;
    } else {
      isFavorite = 0;
    }
    notifyListeners();
  }

  Produto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    photo = json['photo'];
    price = json['price'];
    isFavorite = json['isFavorite'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['photo'] = this.photo;
    data['price'] = this.price;
    data['isFavorite'] = this.isFavorite;
    data['category_id'] = this.categoryId;
    return data;
  }

  // Future<void> toggleFavorite() async {
  //   try {
  //     _toggleFavorite();
  //     final response = await http.patch(
  //       Uri.parse('${Constants.PRODUTO_BASE_URL}/${id - 1}.json'),
  //       body: jsonEncode(
  //         {"isFavorite": isFavorite},
  //       ),
  //     );
  //     if (response.statusCode >= 400) {
  //       _toggleFavorite();
  //     }
  //   } catch (error) {
  //     _toggleFavorite();
  //   }
  // }
}
