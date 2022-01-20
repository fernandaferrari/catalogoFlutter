// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$produtosAtom = Atom(name: '_HomeControllerBase.produtos');

  @override
  List<Produto>? get produtos {
    _$produtosAtom.reportRead();
    return super.produtos;
  }

  @override
  set produtos(List<Produto>? value) {
    _$produtosAtom.reportWrite(value, super.produtos, () {
      super.produtos = value;
    });
  }

  final _$categoriaAtom = Atom(name: '_HomeControllerBase.categoria');

  @override
  List<Categoria>? get categoria {
    _$categoriaAtom.reportRead();
    return super.categoria;
  }

  @override
  set categoria(List<Categoria>? value) {
    _$categoriaAtom.reportWrite(value, super.categoria, () {
      super.categoria = value;
    });
  }

  final _$cartAtom = Atom(name: '_HomeControllerBase.cart');

  @override
  Map<String, CarrinhoItens>? get cart {
    _$cartAtom.reportRead();
    return super.cart;
  }

  @override
  set cart(Map<String, CarrinhoItens>? value) {
    _$cartAtom.reportWrite(value, super.cart, () {
      super.cart = value;
    });
  }

  final _$initAsyncAction = AsyncAction('_HomeControllerBase.init');

  @override
  Future<dynamic> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  final _$loadProdutosAsyncAction =
      AsyncAction('_HomeControllerBase.loadProdutos');

  @override
  Future<void> loadProdutos() {
    return _$loadProdutosAsyncAction.run(() => super.loadProdutos());
  }

  final _$loadCartAsyncAction = AsyncAction('_HomeControllerBase.loadCart');

  @override
  Future loadCart() {
    return _$loadCartAsyncAction.run(() => super.loadCart());
  }

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  dynamic toggleIsFavorite(dynamic item) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.toggleIsFavorite');
    try {
      return super.toggleIsFavorite(item);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic buscaNome(dynamic text) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.buscaNome');
    try {
      return super.buscaNome(text);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic filtro(dynamic value) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.filtro');
    try {
      return super.filtro(value);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic buscarCategoria(dynamic cat) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.buscarCategoria');
    try {
      return super.buscarCategoria(cat);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
produtos: ${produtos},
categoria: ${categoria},
cart: ${cart}
    ''';
  }
}
