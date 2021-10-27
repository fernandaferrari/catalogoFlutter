import 'package:flutter/material.dart';

class Categoria {
  int? id;
  String? name;

  Categoria({this.id, this.name});

  Categoria.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }

  @override
  String toString() {
    return id.toString() + "-" + name!;
  }
}
