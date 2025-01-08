import 'dart:ffi';

class Transacao {
  int? transacaoId;
  String? descricao;
  Float? valor;

  Transacao({this.transacaoId, required this.descricao, required this.valor});
}
