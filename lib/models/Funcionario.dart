import 'package:flutter/material.dart';
import 'package:takasukonomuro/models/Enums/Cargo.dart';

class Funcionario {
  int? login;
  String nome;
  String senha;
  Cargo cargo;
  String cpf;

  Funcionario({
    this.login,
    required this.cpf,
    required this.nome,
    required this.senha,
    required this.cargo,
  });

  String getCargo() {
    if (cargo == Cargo.Garcom) {
      return 'Garcom';
    } else if (cargo == Cargo.Gerente)
      return 'Gerente';
    else
      throw new Exception("Funcionario sem Cargo");
  }

  @override
  String toString() {
    return 'Funcionario(login: $login, nome: $nome, senha: $senha, cargo: $cargo, cpf: $cpf)';
  }
}
