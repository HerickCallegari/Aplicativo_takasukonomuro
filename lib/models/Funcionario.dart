import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:takasukonomuro/models/enums/cargo.dart';

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
  }) {
    this.senha = encriptarSenha(senha);
  }

  String getCargo() {
    if (cargo == Cargo.Garcom) {
      return 'Garcom';
    } else if (cargo == Cargo.Gerente)
      return 'Gerente';
    else
      throw new Exception("Funcionario sem Cargo");
  }

  bool verificarSenha(String senha) {
    return encriptarSenha(senha) == this.senha;
  }

  String encriptarSenha(String senha) {
    var bytes = utf8.encode(senha); // Converte a string em bytes
    var digest = sha256.convert(bytes); // Gera o hash SHA-256
    return digest.toString(); // Retorna o hash como string
  }

  @override
  String toString() {
    return 'Funcionario(login: $login, nome: $nome, senha: $senha, cargo: $cargo, cpf: $cpf)';
  }
}
