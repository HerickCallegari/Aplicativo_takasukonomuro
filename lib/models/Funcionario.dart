import 'package:takasukonomuro/models/Cargo.dart';

class Funcionario {
  late final int login;
  final String nome;
  final String senha;
  final Cargo cargo;
  final String cpf;

  Funcionario({
    required this.login,
    required this.cpf,
    required this.nome,
    required this.senha,
    required this.cargo,
  });

  String GetNome() => nome;
  String GetSenha() => senha;
}
