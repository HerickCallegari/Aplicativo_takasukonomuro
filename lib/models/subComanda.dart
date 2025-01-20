import 'package:flutter/material.dart';

class SubComanda {
  int? subComandaId;
  int comandaId;
  double valorTotal;
  int quantidadeProdutos;
  DateTime dataLancamento;

  SubComanda(
      {this.subComandaId,
      required this.comandaId,
      required this.valorTotal,
      required this.dataLancamento,
      required this.quantidadeProdutos});
}
