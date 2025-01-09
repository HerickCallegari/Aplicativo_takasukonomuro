import 'package:takasukonomuro/models/itemcomanda.dart';

abstract class IItemComandaRepository {
  Future<void> add(ItemComanda itemcomanda);
  Future<void> update(ItemComanda itemcomanda);
  Future<void> remove(ItemComanda itemcomanda);
  Future<List<ItemComanda>> findAll();
  Future<ItemComanda?> findBy(String id);
}
