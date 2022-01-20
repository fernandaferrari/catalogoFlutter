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

  final _$totalAtom = Atom(name: '_CarrinhoControllerBase.total');

  @override
  double? get total {
    _$totalAtom.reportRead();
    return super.total;
  }

  @override
  set total(double? value) {
    _$totalAtom.reportWrite(value, super.total, () {
      super.total = value;
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
  void criarPedido(List<CarrinhoItens> cart, double total) {
    final _$actionInfo = _$_CarrinhoControllerBaseActionController.startAction(
        name: '_CarrinhoControllerBase.criarPedido');
    try {
      return super.criarPedido(cart, total);
    } finally {
      _$_CarrinhoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void totalAmount() {
    final _$actionInfo = _$_CarrinhoControllerBaseActionController.startAction(
        name: '_CarrinhoControllerBase.totalAmount');
    try {
      return super.totalAmount();
    } finally {
      _$_CarrinhoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeCarrinho(dynamic productId) {
    final _$actionInfo = _$_CarrinhoControllerBaseActionController.startAction(
        name: '_CarrinhoControllerBase.removeCarrinho');
    try {
      return super.removeCarrinho(productId);
    } finally {
      _$_CarrinhoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void itensClear() {
    final _$actionInfo = _$_CarrinhoControllerBaseActionController.startAction(
        name: '_CarrinhoControllerBase.itensClear');
    try {
      return super.itensClear();
    } finally {
      _$_CarrinhoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addItem(Produto produto) {
    final _$actionInfo = _$_CarrinhoControllerBaseActionController.startAction(
        name: '_CarrinhoControllerBase.addItem');
    try {
      return super.addItem(produto);
    } finally {
      _$_CarrinhoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeUmItem(dynamic id) {
    final _$actionInfo = _$_CarrinhoControllerBaseActionController.startAction(
        name: '_CarrinhoControllerBase.removeUmItem');
    try {
      return super.removeUmItem(id);
    } finally {
      _$_CarrinhoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
carrinho: ${carrinho},
pedido: ${pedido},
total: ${total}
    ''';
  }
}
