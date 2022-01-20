// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pedido_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PedidoController on _PedidoControllerBase, Store {
  final _$pedidosAtom = Atom(name: '_PedidoControllerBase.pedidos');

  @override
  List<Pedido>? get pedidos {
    _$pedidosAtom.reportRead();
    return super.pedidos;
  }

  @override
  set pedidos(List<Pedido>? value) {
    _$pedidosAtom.reportWrite(value, super.pedidos, () {
      super.pedidos = value;
    });
  }

  final _$initAsyncAction = AsyncAction('_PedidoControllerBase.init');

  @override
  Future<List<Pedido>> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  final _$reloadPedidosAsyncAction =
      AsyncAction('_PedidoControllerBase.reloadPedidos');

  @override
  Future<List<Pedido>> reloadPedidos() {
    return _$reloadPedidosAsyncAction.run(() => super.reloadPedidos());
  }

  @override
  String toString() {
    return '''
pedidos: ${pedidos}
    ''';
  }
}
