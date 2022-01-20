// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gerenciador_produto_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GerenciadorProdutoController
    on _GerenciadorProdutoControllerBase, Store {
  final _$itemProdutosAtom =
      Atom(name: '_GerenciadorProdutoControllerBase.itemProdutos');

  @override
  ObservableList<Produto> get itemProdutos {
    _$itemProdutosAtom.reportRead();
    return super.itemProdutos;
  }

  @override
  set itemProdutos(ObservableList<Produto> value) {
    _$itemProdutosAtom.reportWrite(value, super.itemProdutos, () {
      super.itemProdutos = value;
    });
  }

  final _$initAsyncAction =
      AsyncAction('_GerenciadorProdutoControllerBase.init');

  @override
  Future<dynamic> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  final _$reloadProdutosAsyncAction =
      AsyncAction('_GerenciadorProdutoControllerBase.reloadProdutos');

  @override
  Future<void> reloadProdutos() {
    return _$reloadProdutosAsyncAction.run(() => super.reloadProdutos());
  }

  final _$_GerenciadorProdutoControllerBaseActionController =
      ActionController(name: '_GerenciadorProdutoControllerBase');

  @override
  Future<void>? excluirProduto({required int id}) {
    final _$actionInfo = _$_GerenciadorProdutoControllerBaseActionController
        .startAction(name: '_GerenciadorProdutoControllerBase.excluirProduto');
    try {
      return super.excluirProduto(id: id);
    } finally {
      _$_GerenciadorProdutoControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  dynamic setProdutos(dynamic newValue) {
    final _$actionInfo = _$_GerenciadorProdutoControllerBaseActionController
        .startAction(name: '_GerenciadorProdutoControllerBase.setProdutos');
    try {
      return super.setProdutos(newValue);
    } finally {
      _$_GerenciadorProdutoControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
itemProdutos: ${itemProdutos}
    ''';
  }
}
