import 'package:takasukonomuro/business/repositories/itemRepository.dart';
import 'package:takasukonomuro/business/services/Interfaces/iItemService.dart';
import 'package:takasukonomuro/models/item.dart';

class Itemservice implements IItemService {
  @override
  late ItemRepository repository = ItemRepository();

  @override
  Future<void> add(Item? item) async {
    if (item == null) {
      throw Exception("Item esta null.");
    } else if (item.descricao == null || item.descricao == '') {
      throw Exception("Item esta sem descrição.");
    } else if (item.preco == null) {
      throw Exception("Item esta sem preço.");
    } else if (item.estoque == null) {
      throw Exception("Item esta sem estoque.");
    } else if (item.categoriaId == null) {
      throw Exception("Item esta sem categoria.");
    }
    try {
      repository.add(item);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Item>> findAll() async {
    List<Item> lista;
    try {
      lista = await repository.findAll();
    } catch (e) {
      rethrow;
    }
    if (lista == null) {
      throw Exception("A lista esta null.");
    }
    return lista;
  }

  @override
  Future<Item?> findBy(String? id) {
    if (id == null || id == '') {
      throw Exception("Id esta null.");
    }
    try {
      return repository.findBy(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> remove(Item? item) async {
    if (item == null) {
      throw Exception("Item esta null.");
    } else if (item.itemId == null || item.itemId == '') {
      throw Exception("Item esta sem id.");
    }
    try {
      repository.remove(item);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(Item? item) async {
    if (item == null) {
      throw Exception("Item esta null.");
    } else if (item.descricao == null || item.descricao == '') {
      throw Exception("Item esta sem descrição.");
    } else if (item.preco == null) {
      throw Exception("Item esta sem preço.");
    } else if (item.estoque == null) {
      throw Exception("Item esta sem estoque.");
    } else if (item.categoriaId == null) {
      throw Exception("Item esta sem categoria.");
    } else if (item.itemId == null) {
      throw Exception("Item esta sem Id.");
    }
    try {
      repository.update(item);
    } catch (e) {
      rethrow;
    }
  }
}
