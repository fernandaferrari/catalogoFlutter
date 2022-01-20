// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produto_form_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProdutoFormController on _ProdutoFormControllerBase, Store {
  final _$itemCategoriaAtom =
      Atom(name: '_ProdutoFormControllerBase.itemCategoria');

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

  @override
  String toString() {
    return '''
itemCategoria: ${itemCategoria}
    ''';
  }
}
