import 'package:takasukonomuro/models/Cargo.dart';

class Funcionario {
  final String nome;
  final String senha;
  final Cargo cargo;

  Funcionario({
    required this.nome,
    required this.senha,
    required this.cargo,
  });

  String GetNome() => nome;
  String GetSenha() => senha;
}
