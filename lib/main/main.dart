import 'package:catalogo/main/modular/app_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

main() async {
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: const Key('teste'),
      debugShowCheckedModeBanner: false,
      title: 'Catalogo',
      theme: ThemeData(primaryColor: Colors.purple),
    ).modular();
  }
}
