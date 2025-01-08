import 'dart:ffi';

class Comanda {
  int? comandaId;
  int? transacaoId;
  int? mesaId;
  int? funcionarioId;
  DateTime data = DateTime.now();
  DateTime horarioAbertura = DateTime.now();
  DateTime? horarioFechamento;
  Float? valorTotal;
  bool pago = false;

  Comanda(
      {this.comandaId,
      this.transacaoId,
      this.mesaId,
      this.funcionarioId,
      required this.data,
      required this.horarioAbertura,
      required this.horarioFechamento,
      required this.valorTotal,
      required this.pago});
}
