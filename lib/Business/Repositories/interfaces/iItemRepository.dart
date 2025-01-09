import 'package:takasukonomuro/models/item.dart';

abstract class IItemRepository {
  Future<void> add(Item item);
  Future<void> update(Item item);
  Future<void> remove(Item item);
  Future<List<Item>> findAll();
  Future<Item?> findBy(String id);
}
