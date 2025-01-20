import 'package:takasukonomuro/models/itemSubComanda.dart';

abstract class IItemSubComandaRepository {
  Future<void> add(ItemSubComanda itemSubComanda);
  Future<void> update(ItemSubComanda itemSubComanda);
  Future<void> remove(ItemSubComanda itemSubComanda);
  Future<List<ItemSubComanda>> findAll();
  Future<ItemSubComanda?> findBy(String id);
}
