import 'package:takasukonomuro/business/repositories/funcionarioRepository.dart';
import 'package:takasukonomuro/models/funcionario.dart';

abstract class IFuncionarioService {
  late FuncionarioRepository repository;
  Future<void> add(Funcionario? funcionario);
  Future<void> update(Funcionario? funcionario);
  Future<void> remove(Funcionario? funcionario);
  Future<Funcionario?> findBy(String? id);
  Future<List<Funcionario>> findAll();
}
