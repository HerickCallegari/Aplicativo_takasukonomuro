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
}
