import 'package:catalogo/main/modular/home_module.dart';
import 'package:catalogo/pages/home/components/busca_nome_produto.dart';
import 'package:catalogo/pages/home/home_controller.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

class HomeControllerMock extends Mock implements HomeController {}

void main() {
  initModule(HomeModule(), replaceBinds: [Bind((i) => HomeControllerMock())]);

  late HomeControllerMock controller;
  setUp(() {
    controller = HomeControllerMock();
  });
  testWidgets('busca nome produto ...', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: BuscaNome(controller: controller)),
    ));

    final nome = faker.person.name();
    await tester.enterText(
        find.bySemanticsLabel('Buscar por nome de produto'), nome);

    verify(() => controller.buscaNome(nome));
  });
}
