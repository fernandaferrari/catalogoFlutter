class ScriptDatabase {
  String get produto => '''
  CREATE TABLE produto(
    id INTEGER NOT NULL PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
    photo TEXT,
    price REAL,
    isFavotire BOOLEAN,
    id_category INTEGER,
    FOREIGN KEY(id_category) REFERENCES categoria(id)
  );
  ''';

  String get categoria => '''
  CREATE TABLE categoria(
    id INTEGER NOT NULL PRIMARY KEY,
    name VARCHAR(100)
  );
  ''';

  String get carrinho => '''
  CREATE TABLE carrinho(
    id INTEGER NOT NULL PRIMARY KEY,
    id_product INTEGER,
    FOREIGN KEY(id_product) REFERENCES produto(id)
  );
  ''';

  String get pedido => '''
  CREATE TABLE pedido(
    id INTEGER NOT NULL PRIMARY KEY,
    name VARCHAR(100),
    total REAL,
    date DATETIME,
    id_carrinho STRING,
    FOREIGN KEY(id_carrinho) REFERENCES carrinho(id)
  );
  ''';

  String get login => '''
  CREATE TABLE login(
    id INTEGER NOT NULL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    password VARCHAR(100),
    date DATETIME,
  );
  ''';
}
