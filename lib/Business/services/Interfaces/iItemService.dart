import 'package:takasukonomuro/business/repositories/itemRepository.dart';
import 'package:takasukonomuro/models/item.dart';

abstract class IItemService {
  late ItemRepository repository;
  Future<void> add(Item? item);
  Future<void> update(Item? item);
  Future<void> remove(Item? item);
  Future<Item?> findBy(String? id);
  Future<List<Item>> findAll();
}
