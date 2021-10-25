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

  final _$initAsyncAction =
      AsyncAction('_GerenciadorProdutoControllerBase.init');

  @override
  Future<dynamic> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  @override
  String toString() {
    return '''
itemProduto: ${itemProduto}
    ''';
  }
}
