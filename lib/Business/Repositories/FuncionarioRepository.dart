// ignore_for_file: unnecessary_null_comparison

import 'package:takasukonomuro/business/repositories/interfaces/iFuncionarioRepository.dart';
import 'package:takasukonomuro/main.dart';
import 'package:takasukonomuro/models/enums/cargo.dart';
import 'package:takasukonomuro/models/funcionario.dart';

class FuncionarioRepository implements IFuncionarioRepository {
  @override
  Future<void> add(Funcionario funcionario) async {
    try {
      await supabase.from('Funcionarios').insert([
        {
          // 'Login' será auto incremental no banco de dados
          'CPF': funcionario.cpf,
          'Senha': funcionario.senha,
          'Nome': funcionario.nome,
          'Cargo': funcionario.getCargo(),
        }
      ]);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> remove(Funcionario funcionario) async {
    try {
      int id = funcionario.login!;
      await supabase.from('Funcionarios').delete().eq('Login', id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Funcionario>> findAll() async {
    try {
      var responseList = await supabase.from("Funcionarios").select('*');
      List<Funcionario> funcionarios = [];

      for (var response in responseList) {
        if (response != null && response is Map<String, dynamic>) {
          Funcionario funcionario = Funcionario(
            cpf: response['CPF'],
            nome: response['Nome'],
            senha: response['Senha'],
            cargo: _getCargo(response),
            login: response['Login'],
          );

          funcionarios.add(funcionario);
        }
      }

      return funcionarios;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Funcionario?> findBy(id) async {
    try {
      var response = await supabase
          .from('Funcionarios')
          .select('CPF, Nome, Login, Senha, Cargo')
          .eq('Login', id)
          .single();

      Funcionario funcionario = Funcionario(
        cpf: response['CPF'],
        nome: response['Nome'],
        senha: response['Senha'],
        cargo: _getCargo(response),
        login: response['Login'],
      );
      return funcionario;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(Funcionario funcionario) async {
    if (funcionario == null) throw Exception("Funcionario não pode ser null");

    try {
      await supabase.from('Funcionarios').update({
        'CPF': funcionario.cpf,
        'Senha': funcionario.senha,
        'Nome': funcionario.nome,
        'Cargo': funcionario.getCargo(),
      }).eq('Login', funcionario.login.toString());
    } catch (e) {
      rethrow;
    }
  }

  Future<Funcionario?> testFetchFuncionario() async {
    var response =
        await supabase.from('Funcionarios').select().limit(1).single();

    var data = response as Map;

    if (data != null && data is Map<String, dynamic>) {
      Funcionario funcionario = Funcionario(
        cpf: data['CPF'],
        nome: data['Nome'],
        senha: data['Senha'],
        cargo: _getCargo(data),
        login: data['Login'],
      );
      return funcionario;
    } else {
      print("Dados do funcionário não encontrados.");
      return null;
    }
  }

  Cargo _getCargo(Map data) {
    Cargo cargo;
    if (data['Cargo'] == 'Gerente') {
      cargo = Cargo.Gerente;
    } else if (data['Cargo'] == 'Garcom') {
      cargo = Cargo.Garcom;
    } else
      throw Exception("Funcionario sem cargo");
    return cargo;
  }
}
