import 'package:takasukonomuro/business/repositories/interfaces/iItemSubComandaRepository.dart';
import 'package:takasukonomuro/main.dart';
import 'package:takasukonomuro/models/itemSubComanda.dart';

class ItemSubComandaRepository implements IItemSubComandaRepository {
  @override
  Future<void> add(ItemSubComanda itemSubComanda) async {
    try {
      await supabase.from('ItemSubComanda').insert([
        {
          // 'Login' será auto incremental no banco de dados
          'SubComandaId': itemSubComanda.subComandaId,
          'ValorTotal': itemSubComanda.valorTotal,
          'QuantidadeProdutos': itemSubComanda.quantidadeProdutos,
          'ItemId': itemSubComanda.itemId
        }
      ]);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ItemSubComanda>> findAll() async {
    try {
      var responseList = await supabase.from("ItemSubComandas").select('*');
      List<ItemSubComanda> ItemSubComandas = [];

      for (var response in responseList) {
        if (response != null && response is Map<String, dynamic>) {
          ItemSubComanda itemsubcomanda = ItemSubComanda(
              itemSubComandaId: response['ItemSubComandaId'],
              subComandaId: response['SubComandaId'],
              valorTotal: response['ValorTotal'] is double
                  ? response['ValorTotal']
                  : double.parse(response['ValorTotal'].toString()),
              quantidadeProdutos: response['QuantidadeProdutos'] is int
                  ? response['QuantidadeProdutos']
                  : int.parse(response['QuantidadeProdutos'].toString()),
              itemId: response['ItemId']);

          ItemSubComandas.add(itemsubcomanda);
        }
      }

      return ItemSubComandas;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ItemSubComanda?> findBy(id) async {
    try {
      var response = await supabase
          .from('ItemSubComandas')
          .select('*')
          .eq('ItemSubComandaId', id)
          .single();

      // ignore: unnecessary_type_check
      if (response != null && response is Map<String, dynamic>) {
        ItemSubComanda itemsubcomanda = ItemSubComanda(
            itemSubComandaId: response['ItemSubComandaId'],
            subComandaId: response['SubComandaId'],
            valorTotal: response['ValorTotal'] is double
                ? response['ValorTotal']
                : double.parse(response['ValorTotal'].toString()),
            quantidadeProdutos: response['QuantidadeProdutos'] is int
                ? response['QuantidadeProdutos']
                : int.parse(response['QuantidadeProdutos'].toString()),
            itemId: response['ItemId']);
        return itemsubcomanda;
      } else {
        throw Exception("Dados do funcionário não encontrados.");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(ItemSubComanda itemSubComanda) async {
    if (ItemSubComanda == null) {
      throw Exception("ItemSubComanda não pode ser null");
    }

    try {
      await supabase.from('ItemSubComandas').update({
        'SubComandaId': itemSubComanda.subComandaId,
        'ValorTotal': itemSubComanda.valorTotal,
        'QuantidadeProdutos': itemSubComanda.quantidadeProdutos,
        'ItemId': itemSubComanda.itemId
      }).eq('ItemSubComandaId', itemSubComanda.itemSubComandaId.toString());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> remove(ItemSubComanda itemsubcomanda) async {
    try {
      await supabase
          .from('ItemSubComandas')
          .delete()
          .eq('ItemSubComandaId', itemsubcomanda.itemSubComandaId.toString());
    } catch (e) {
      rethrow;
    }
  }
}
