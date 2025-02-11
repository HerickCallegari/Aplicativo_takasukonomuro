import 'package:takasukonomuro/business/repositories/funcionarioRepository.dart';
import 'package:takasukonomuro/business/services/Interfaces/iFuncionarioService.dart';
import 'package:takasukonomuro/models/funcionario.dart';

class FuncionarioService implements IFuncionarioService {
  @override
  late FuncionarioRepository repository = FuncionarioRepository();

  @override
  Future<void> add(Funcionario? funcionario) async {
    if (funcionario == null) {
      throw Exception("Funcionario null.");
    } else if (funcionario.cargo == null) {
      throw Exception("Funcionario sem cargo.");
    } else if (funcionario.cpf == null || funcionario.cpf == '') {
      throw Exception("Funcionario sem CPF.");
    } else if (funcionario.nome == null || funcionario.nome == '') {
      throw Exception("Funcionario sem nome.");
    } else if (funcionario.senha == null || funcionario.senha == '') {
      throw Exception("Funcionario sem senha.");
    }
    try {
      repository.add(funcionario);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Funcionario>> findAll() async {
    List<Funcionario> lista;

    try {
      lista = await repository.findAll();
    } catch (e) {
      rethrow;
    }

    return lista;
  }

  @override
  Future<Funcionario?> findBy(String? id) async {
    if (id == null || id == '') {
      throw Exception("id null.");
    }

    try {
      return await repository.findBy(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> remove(Funcionario? funcionario) async {
    if (funcionario == null) {
      throw Exception("Funcionario null");
    } else if (funcionario.login == '' || funcionario.login == null) {
      throw Exception("Funcionario sem Login");
    }
    try {
      repository.remove(funcionario);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(Funcionario? funcionario) async {
    if (funcionario == null) {
      throw Exception("Funcionario null.");
    } else if (funcionario.cargo == null) {
      throw Exception("Funcionario sem cargo.");
    } else if (funcionario.cpf == null || funcionario.cpf == '') {
      throw Exception("Funcionario sem CPF.");
    } else if (funcionario.nome == null || funcionario.nome == '') {
      throw Exception("Funcionario sem nome.");
    } else if (funcionario.senha == null || funcionario.senha == '') {
      throw Exception("Funcionario sem senha.");
    } else if (funcionario.login == '' || funcionario.login == null) {
      throw Exception("Funcionario sem Login");
    }

    try {
      repository.update(funcionario);
    } catch (e) {
      rethrow;
    }
  }
}
