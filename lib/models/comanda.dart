import 'dart:ffi';

class Comanda {
  int? comandaId;
  int mesaId;
  int funcionarioId;
  DateTime data = DateTime.now();
  DateTime horarioAbertura = DateTime.now();
  DateTime? horarioFechamento;
  double valorTotal;
  int quantidadePessoas;
  bool pago = false;

  Comanda(
      {this.comandaId,
      required this.mesaId,
      required this.funcionarioId,
      required this.data,
      required this.quantidadePessoas,
      required this.horarioAbertura,
      this.horarioFechamento,
      required this.valorTotal,
      required this.pago});

  @override
  String toString() {
    return "Comanda: " + comandaId.toString();
  }
}
