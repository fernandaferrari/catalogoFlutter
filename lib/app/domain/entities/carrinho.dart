class CarrinhoItens {
  final int id;
  final int produtoId;
  final String name;
  final int quantity;
  final num price;
  final String photo;

  CarrinhoItens(
      {required this.id,
      required this.produtoId,
      required this.name,
      required this.quantity,
      required this.price,
      required this.photo});
}
