import 'package:takasukonomuro/models/subComanda.dart';

abstract class ISubComandaRepository {
  Future<void> add(SubComanda subComanda);
  Future<void> update(SubComanda subComanda);
  Future<void> remove(SubComanda subComanda);
  Future<List<SubComanda>> findAll();
  Future<SubComanda?> findBy(String id);
}
