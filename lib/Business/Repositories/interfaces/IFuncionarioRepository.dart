import 'package:takasukonomuro/models/Funcionario.dart';

abstract class IFuncionarioRepository {
  Future<void> add(Funcionario funcionario);
  Future<void> update(Funcionario funcionario);
  Future<List<Funcionario>> findAll();
  Future<Funcionario?> findBy(String id);
}
