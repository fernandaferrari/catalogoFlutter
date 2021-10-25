// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carrinho_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CarrinhoController on _CarrinhoControllerBase, Store {
  final _$carrinhoAtom = Atom(name: '_CarrinhoControllerBase.carrinho');

  @override
  List<CarrinhoItens>? get carrinho {
    _$carrinhoAtom.reportRead();
    return super.carrinho;
  }

  @override
  set carrinho(List<CarrinhoItens>? value) {
    _$carrinhoAtom.reportWrite(value, super.carrinho, () {
      super.carrinho = value;
    });
  }

  final _$pedidoAtom = Atom(name: '_CarrinhoControllerBase.pedido');

  @override
  List<CarrinhoItens>? get pedido {
    _$pedidoAtom.reportRead();
    return super.pedido;
  }

  @override
  set pedido(List<CarrinhoItens>? value) {
    _$pedidoAtom.reportWrite(value, super.pedido, () {
      super.pedido = value;
    });
  }

  final _$_initAsyncAction = AsyncAction('_CarrinhoControllerBase._init');

  @override
  Future _init() {
    return _$_initAsyncAction.run(() => super._init());
  }

  final _$_CarrinhoControllerBaseActionController =
      ActionController(name: '_CarrinhoControllerBase');

  @override
  dynamic criarPedido() {
    final _$actionInfo = _$_CarrinhoControllerBaseActionController.startAction(
        name: '_CarrinhoControllerBase.criarPedido');
    try {
      return super.criarPedido();
    } finally {
      _$_CarrinhoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
carrinho: ${carrinho},
pedido: ${pedido}
    ''';
  }
}
