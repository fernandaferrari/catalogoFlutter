import 'package:catalogo/app/domain/entities/carrinho.dart';
import 'package:catalogo/app/domain/entities/produto.dart';
import 'package:catalogo/app/domain/interfaces/carrinho_repository.dart';
import 'package:catalogo/app/infra/database/sqlite/connection.dart';
import 'package:sqflite/sqflite.dart';

class CarrinhoRepository implements ICarrinhoRepository {
  late Database _db;

  @override
  Future<List<CarrinhoItens>> AllCarrinho() {
    // TODO: implement AllCarrinho
    throw UnimplementedError();
  }

  @override
  remove(int id) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  save(CarrinhoItens carrinho) {
    // TODO: implement save
    throw UnimplementedError();
  }
}

  // @override
  // Future<List<CarrinhoItens>> AllCarrinho() async {
  //   // _db = await Connection.instance.database;
  //   // List<Map<String, dynamic>> resultado = await _db.query('carrinho');
  //   // //List<CarrinhoItens> carrinho = List.generate(resultado.length, (index) {
  //   //   var item = resultado[index];
  //   //   // return CarrinhoEntity(
  //   //   //     id: item['id'],
  //   //   //     quantity: item['quantity'],
  //   //   //     id_produto: item['id_produto']);
  //   // });

  //   // //return carrinho;
  // }

  // @override
  // remove(int id) async {
  //   _db = await Connection.instance.database;
  //   var sql = 'DELETE FROM produto WHERE id=?';
  //   _db.rawDelete(sql, [id]);
  // }

  // @override
  // save(CarrinhoItens carrinho) async {
  //   // _db = await Connection.instance.database;
  //   // var sql;
  //   // if (carrinho.id == null) {
  //   //   sql = 'INSERT INTO carrinho(id_produto, quantity) VALUES(?)';
  //   //   _db.rawInsert(sql, [carrinho.id_produto, carrinho.quantity]);
  //   // } else {
  //   //   sql = 'UPDATE carrinho SET id_produto=?,quantity=? WHERE id=?';
  //   //   _db.rawUpdate(sql, [carrinho.id_produto, carrinho.quantity, carrinho.id]);
  //   // }
  // }