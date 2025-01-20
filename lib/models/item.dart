import 'dart:ffi';

class Item {
  int? itemId;
  int categoriaId;
  String descricao;
  double preco;
  int estoque;

  Item(
      {this.itemId,
      required this.categoriaId,
      required this.descricao,
      required this.preco,
      required this.estoque});
}
