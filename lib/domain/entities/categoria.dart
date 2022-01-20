class Categoria {
  int? id;
  String? name;

  Categoria({this.id, this.name});

  @override
  String toString() {
    return id.toString() + "-" + name!;
  }
}
