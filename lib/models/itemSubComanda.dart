import 'dart:ffi';

class ItemSubComanda {
  int? itemSubComandaId;
  int itemId;
  int subComandaId;
  int quantidadeProdutos;
  double valorTotal;

  ItemSubComanda(
      {this.itemSubComandaId,
      required this.subComandaId,
      required this.itemId,
      required this.quantidadeProdutos,
      required this.valorTotal});
}
