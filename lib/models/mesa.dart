import 'package:flutter/material.dart';
import 'package:takasukonomuro/models/enums/status.dart';

class Mesa {
  int? mesaId;
  String descricao;
  Status status;

  Mesa({
    this.mesaId,
    required this.descricao,
    required this.status,
  });

  String getStatus() {
    if (status == Status.Ocupado) {
      return 'Ocupado';
    } else if (status == Status.Reservado) {
      return 'Reservado';
    } else {
      return 'Livre';
    }
  }
}
