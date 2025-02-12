import 'package:takasukonomuro/business/repositories/subComandaRepository.dart';
import 'package:takasukonomuro/models/subComanda.dart';

abstract class ISubComandaService {
  late SubComandaRepository repository;
  Future<void> add(SubComanda? subcomanda);
  Future<void> update(SubComanda? subcomanda);
  Future<void> remove(SubComanda? subcomanda);
  Future<SubComanda?> findBy(String? id);
  Future<List<SubComanda>> findAll();
}
