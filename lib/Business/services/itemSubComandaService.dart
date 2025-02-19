import 'package:takasukonomuro/business/repositories/ItemSubComandaRepository.dart';
import 'package:takasukonomuro/business/services/Interfaces/iItemSubComandaService.dart';
import 'package:takasukonomuro/models/itemSubComanda.dart';

class ItemSubComandasService implements IItemSubComandaService {
  @override
  ItemSubComandaRepository repository = ItemSubComandaRepository();

  @override
  Future<void> add(ItemSubComanda? itemsubcomanda) async {
    if (itemsubcomanda == null) {
      throw Exception("itemSubComanda esta null.");
    } else if (itemsubcomanda.itemId == null) {
      throw Exception("itemSubComanda esta sem item.");
    } else if (itemsubcomanda.subComandaId == null) {
      throw Exception("itemSubComanda esta sem subComanda.");
    } else if (itemsubcomanda.valorTotal == null) {
      throw Exception("itemSubComanda esta sem valor total.");
    }

    try {
      repository.add(itemsubcomanda);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ItemSubComanda>> findAll() async {
    List<ItemSubComanda> lista;
    try {
      lista = await repository.findAll();
    } catch (e) {
      rethrow;
    }
    return lista;
  }

  @override
  Future<ItemSubComanda?> findBy(String? id) {
    if (id == null || id == '') {
      throw Exception("ID esta null");
    }

    try {
      return repository.findBy(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> remove(ItemSubComanda? itemsubcomanda) async {
    if (itemsubcomanda == null || itemsubcomanda.itemSubComandaId == null) {
      throw Exception("itemSubComanda esta null.");
    }

    try {
      repository.remove(itemsubcomanda);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(ItemSubComanda? itemsubcomanda) async {
    if (itemsubcomanda == null) {
      throw Exception("itemSubComanda esta null.");
    } else if (itemsubcomanda.itemId == null) {
      throw Exception("itemSubComanda esta sem item.");
    } else if (itemsubcomanda.subComandaId == null) {
      throw Exception("itemSubComanda esta sem subComanda.");
    } else if (itemsubcomanda.valorTotal == null) {
      throw Exception("itemSubComanda esta sem valor total.");
    } else if (itemsubcomanda.itemSubComandaId == null) {
      throw Exception("itemSubComanda esta sem ID.");
    }

    try {
      repository.update(itemsubcomanda);
    } catch (e) {
      rethrow;
    }
  }
}
