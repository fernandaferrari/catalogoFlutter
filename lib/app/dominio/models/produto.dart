import 'dart:convert';
import 'package:flutter/foundation.dart';

class Produto with ChangeNotifier {
  late int id;
  late String name;
  late String description;
  late String photo;
  late num price;
  int? categoryId;
  late bool isFavorite;

  Produto(
      {required this.id,
      required this.name,
      required this.description,
      required this.photo,
      required this.price,
      this.categoryId,
      this.isFavorite = false});

  void _toggleFavorite() {
    isFavorite = !isFavorite;
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
}
