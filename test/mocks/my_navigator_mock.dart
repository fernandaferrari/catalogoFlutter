import 'package:flutter_modular/flutter_modular.dart';
import 'package:mockito/mockito.dart';

class MyNavigatorMock extends Mock implements IModularNavigator {
  @override
  Future<T?> pushNamed<T extends Object?>(String? routeName,
          {Object? arguments, bool? forRoot = false}) =>
      (super.noSuchMethod(
          Invocation.method(#pushNamed, [routeName],
              {#arguments: arguments, #forRoot: forRoot}),
          returnValue: Future.value(null)) as Future<T?>);
}
