import 'package:catalogo/main/modular/app_module.dart';
import 'package:catalogo/main/modular/home_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:modular_test/modular_test.dart';

import '../mocks/my_navigator_mock.dart';

void main() {
  initModule(AppModule());
  var navigatorMock = MyNavigatorMock();

  // Modular.to and Modular.link will be called MyNavigatorMock implements!
  Modular.navigatorDelegate = navigatorMock;
  testWidgets('app module ...', (tester) async {
    when(navigatorMock.pushNamed('/'))
        .thenAnswer((_) async => initModule(HomeModule()));

    Modular.to.pushNamed('/');
    verify(navigatorMock.pushNamed('/')).called(1);
  });
}
