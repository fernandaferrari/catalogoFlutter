// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gerenciador_produto_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GerenciadorProdutoController
    on _GerenciadorProdutoControllerBase, Store {
  final _$itemProdutoAtom =
      Atom(name: '_GerenciadorProdutoControllerBase.itemProduto');

  @override
  List<Produto>? get itemProduto {
    _$itemProdutoAtom.reportRead();
    return super.itemProduto;
  }

  @override
  set itemProduto(List<Produto>? value) {
    _$itemProdutoAtom.reportWrite(value, super.itemProduto, () {
      super.itemProduto = value;
    });
  }

  final _$itemCategoriaAtom =
      Atom(name: '_GerenciadorProdutoControllerBase.itemCategoria');

  @override
  List<Categoria>? get itemCategoria {
    _$itemCategoriaAtom.reportRead();
    return super.itemCategoria;
  }

  @override
  set itemCategoria(List<Categoria>? value) {
    _$itemCategoriaAtom.reportWrite(value, super.itemCategoria, () {
      super.itemCategoria = value;
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
  Future reloadProdutos() {
    return _$reloadProdutosAsyncAction.run(() => super.reloadProdutos());
  }

  final _$_GerenciadorProdutoControllerBaseActionController =
      ActionController(name: '_GerenciadorProdutoControllerBase');

  @override
  dynamic categoria() {
    final _$actionInfo = _$_GerenciadorProdutoControllerBaseActionController
        .startAction(name: '_GerenciadorProdutoControllerBase.categoria');
    try {
      return super.categoria();
    } finally {
      _$_GerenciadorProdutoControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  dynamic excluirProduto(dynamic id) {
    final _$actionInfo = _$_GerenciadorProdutoControllerBaseActionController
        .startAction(name: '_GerenciadorProdutoControllerBase.excluirProduto');
    try {
      return super.excluirProduto(id);
    } finally {
      _$_GerenciadorProdutoControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
itemProduto: ${itemProduto},
itemCategoria: ${itemCategoria}
    ''';
  }
}
