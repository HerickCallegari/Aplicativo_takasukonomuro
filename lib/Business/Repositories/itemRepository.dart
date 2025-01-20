// ignore_for_file: unnecessary_null_comparison

import 'package:takasukonomuro/business/repositories/interfaces/iItemRepository.dart';
import 'package:takasukonomuro/main.dart';
import 'package:takasukonomuro/models/item.dart';

class ItemRepository implements IItemRepository {
  @override
  Future<void> add(Item item) async {
    try {
      await supabase.from('Items').insert([
        {
          // 'ItemId' será auto incremental no banco de dados
          'CategoriaId': item.categoriaId,
          'Descricao': item.descricao,
          'Preco': item.preco,
          'Estoque': item.estoque
        }
      ]);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Item>> findAll() async {
    try {
      var responseList = await supabase.from("Items").select('*');
      List<Item> Items = [];

      for (var response in responseList) {
        if (response != null && response is Map<String, dynamic>) {
          Item item = Item(
              itemId: response['ItemId'],
              descricao: response['Descricao'],
              estoque: response['Estoque'],
              preco: response['Preco'],
              categoriaId: response['CategoriaId']);

          Items.add(item);
        }
      }

      return Items;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Item?> findBy(id) async {
    try {
      var response =
          await supabase.from('Items').select('*').eq('id', id).single();

      // ignore: unnecessary_type_check
      if (response != null && response is Map<String, dynamic>) {
        Item item = Item(
            itemId: response['ItemId'],
            descricao: response['Descricao'],
            estoque: response['Estoque'],
            preco: response['Preco'],
            categoriaId: response['CategoriaId']);

        return item;
      } else {
        throw Exception("Dados do funcionário não encontrados.");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(Item item) async {
    if (Item == null) throw Exception("Item não pode ser null");

    try {
      await supabase.from('Items').update({
        'CategoriaId': item.categoriaId,
        'Descricao': item.descricao,
        'Preco': item.preco,
        'Estoque': item.estoque
      }).eq('ItemId', item.itemId.toString());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> remove(Item item) async {
    try {
      await supabase
          .from('Items')
          .delete()
          .eq('ItemId', item.itemId.toString());
    } catch (e) {
      rethrow;
    }
  }
}
