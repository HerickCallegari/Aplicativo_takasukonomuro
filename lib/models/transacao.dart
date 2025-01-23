import 'dart:ffi';

import 'package:takasukonomuro/models/enums/tipoTransacao.dart';

class Transacao {
  int? transacaoId;
  int comandaId;
  Tipotransacao tipoTransacao;
  double valor;
  DateTime data;

  Transacao(
      {this.transacaoId,
      required this.comandaId,
      required this.tipoTransacao,
      required this.valor,
      required this.data});

  String getTipoTransacao() {
    if (tipoTransacao == Tipotransacao.Credito) {
      return "Credito";
    } else if (tipoTransacao == Tipotransacao.Debito) {
      return 'Debito';
    } else if (tipoTransacao == Tipotransacao.Dinheiro) {
      return 'Dinheiro';
    } else if (tipoTransacao == Tipotransacao.Pix) {
      return 'Pix';
    } else {
      return "Outro";
    }
  }
}
