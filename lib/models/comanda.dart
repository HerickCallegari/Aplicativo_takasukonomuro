import 'dart:ffi';

class Comanda {
  int? comandaId;
  int mesaId;
  int funcionarioId;
  DateTime data = DateTime.now();
  DateTime horarioAbertura = DateTime.now();
  DateTime? horarioFechamento;
  double valorTotal;
  bool pago = false;

  Comanda(
      {this.comandaId,
      required this.mesaId,
      required this.funcionarioId,
      required this.data,
      required this.horarioAbertura,
      this.horarioFechamento,
      required this.valorTotal,
      required this.pago});
}
