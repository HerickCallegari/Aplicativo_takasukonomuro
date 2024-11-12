import 'package:takasukonomuro/models/Enums/Cargo.dart';

class Funcionario {
  final int? login;
  final String nome;
  final String senha;
  final Cargo cargo;
  final String cpf;

  Funcionario({
    this.login,
    required this.cpf,
    required this.nome,
    required this.senha,
    required this.cargo,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'login': login,
      'senha': senha,
      'cpf': cpf,
      'cargo': cargo.index,
    };
  }

  @override
  String toString() {
    return 'Funcionario(login: $login, nome: $nome, senha: $senha, cargo: $cargo, cpf: $cpf)';
  }
}
