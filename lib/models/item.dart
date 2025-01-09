import 'dart:ffi';

class Item {
  int? itemId;
  int categoriaId;
  String descricao;
  Float preco;

  Item(
      {this.itemId,
      required this.categoriaId,
      required this.descricao,
      required this.preco});
}
