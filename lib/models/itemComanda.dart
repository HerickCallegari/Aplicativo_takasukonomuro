import 'dart:ffi';

class ItemComanda {
  int? itemComandaId;
  int itemId;
  int comandaId;
  int quantidade;
  Float preco;

  ItemComanda(
      {this.itemComandaId,
      required this.comandaId,
      required this.itemId,
      required this.quantidade,
      required this.preco});
}
