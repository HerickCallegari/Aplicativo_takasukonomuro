import 'package:takasukonomuro/models/comanda.dart';

abstract class IComandaRepository {
  Future<void> add(Comanda comanda);
  Future<void> update(Comanda comanda);
  Future<void> remove(Comanda comanda);
  Future<List<Comanda>> findAll();
  Future<Comanda?> findBy(String id);
}
