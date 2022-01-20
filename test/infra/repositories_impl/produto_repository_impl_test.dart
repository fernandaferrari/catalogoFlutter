import 'package:catalogo/database/sqlite/connection.dart';
import 'package:catalogo/domain/entities/produto.dart';
import 'package:catalogo/infra/local_repository/local_produto_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class ConnectionMock extends Mock implements Connection {
  When mockQueryAll() => when(() => queryAllProdutos());

  void allProdutosMock() => mockQueryAll().thenAnswer((_) => [
        {
          'id': 4,
          'name': 'Teste',
          'description': 'teste',
          'isFavorite': 0,
          'price': 2000,
          'photo': 'teste.jpg',
          'id_category': 4
        }
      ]);

  When mockUltimoRegistroCall() => when(() => ultimoRegistro());

  void mockUltimoRegistro() => mockUltimoRegistroCall().thenAnswer((_) => [
        {
          'id': 4,
          'name': 'Teste',
          'description': 'teste',
          'isFavorite': 0,
          'price': 2000,
          'photo': 'teste.jpg',
          'id_category': 4
        }
      ]);
}

void main() {
  late ConnectionMock bd;
  late LocalProdutoRepository sut;

  setUp(() {
    bd = ConnectionMock();
    bd.allProdutosMock();
    bd.mockUltimoRegistro();
    sut = LocalProdutoRepository(bd: bd);
  });
  test('testando allProdutos', () async {
    await sut.allProdutos();

    verify(() => bd.queryAllProdutos()).called(1);
  });

  test('Testando chamada removeProduto', () async {
    var sql = 'DELETE FROM produto WHERE id=?';
    var id = 4;
    await sut.remove(4);

    verify(() => bd.excluirProduto(sql: sql, id: id)).called(1);
  });

  test('Testando chamada saveProduto', () async {
    var sql =
        'INSERT INTO produto(name, description, photo, price, id_category, isFavorite) VALUES (?,?,?,?,?,?)';

    var produto = Produto(
        name: 'Teste',
        description: 'Testando',
        categoryId: 4,
        price: 200,
        isFavorite: 0,
        photo: 'image.jpg');

    await sut.save(produto: produto);

    verify(() => bd.insertProduto(sql: sql, produto: produto)).called(1);
  });

  test('Testando chamada produto update', () async {
    var sql =
        'UPDATE produto SET name=?, description=?, photo=?, price=?, id_category=?, isFavorite=? WHERE id=?';
    var produto = Produto(
        id: 4,
        name: 'Teste',
        description: 'Testando',
        categoryId: 4,
        price: 300,
        isFavorite: 0,
        photo: 'image.jpg');

    await sut.save(produto: produto);

    verify(() => bd.updateProduto(sql: sql, produto: produto)).called(1);
  });

  test('Testando chamada toggleFavorite', () async {
    var sql = 'UPDATE produto SET isFavorite=? WHERE id=?';
    var produto = Produto(
        id: 4,
        name: 'Teste',
        description: 'Testando',
        categoryId: 4,
        price: 300,
        isFavorite: 0,
        photo: 'image.jpg');

    await sut.toggleFavorite(produto);

    verify(() => bd.updateIsFavorite(sql: sql, produto: produto)).called(1);
  });
}
