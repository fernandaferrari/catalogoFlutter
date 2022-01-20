import 'package:catalogo/pages/home/home_controller.dart';
import 'package:flutter/material.dart';

class BuscaNome extends StatelessWidget {
  const BuscaNome({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        controller.buscaNome(value);
      },
      decoration: const InputDecoration(
        labelText: 'Buscar por nome de produto',
        suffixIcon: Icon(Icons.search),
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.black),
      ),
    );
  }
}
