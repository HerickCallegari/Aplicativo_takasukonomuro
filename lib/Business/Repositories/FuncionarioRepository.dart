import 'package:flutter/material.dart';
import 'package:takasukonomuro/Business/Repositories/Interfaces/IRepository.dart';
import 'package:takasukonomuro/main.dart';
import 'package:takasukonomuro/models/Enums/Cargo.dart';
import 'package:takasukonomuro/models/Funcionario.dart';

class FuncionarioRepository implements IFuncionarioRepository {
  @override
  Future<void> add(Funcionario funcionario) async {
    final response =
        await supabase.from('Funcionarios').insert([funcionario.toMap()]);

    if (response.error != null) {
      throw Exception(
          "Erro ao inserir funcionário: ${response.error!.message}");
    } else {
      print("Funcionário inserido com sucesso!");
    }
  }

  @override
  Future<List<Funcionario>> findAll() {
    // TODO: implement findAll
    throw UnimplementedError();
  }

  @override
  Future<Funcionario?> findBy(id) {
    // TODO: implement findBy
    throw UnimplementedError();
  }

  @override
  Future<void> update(Funcionario objeto) {
    // TODO: implement update
    throw UnimplementedError();
  }

  Future<Funcionario?> testFetchFuncionario() async {
    final response =
        await supabase.from('Funcionarios').select().limit(1).single();

    final data = response as Map;

    if (data != null && data is Map<String, dynamic>) {
      Cargo cargo;
      if (data['Cargo'] == 'Gerente') {
        cargo = Cargo.Gerente;
      } else {
        cargo = Cargo.Garcom;
      }

      Funcionario funcionario = Funcionario(
        cpf: data['CPF'],
        nome: data['Nome'],
        senha: data['Senha'],
        cargo: cargo,
        login: data['Login'],
      );
      return funcionario;
    } else {
      print("Dados do funcionário não encontrados.");
      return null;
    }
  }
}
