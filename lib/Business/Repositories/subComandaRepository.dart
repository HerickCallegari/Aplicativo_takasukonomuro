import 'package:takasukonomuro/business/repositories/interfaces/iSubComandaRepository.dart';
import 'package:takasukonomuro/main.dart';
import 'package:takasukonomuro/models/subComanda.dart';

class SubComandaRepository implements ISubComandaRepository {
  @override
  Future<void> add(SubComanda subComanda) async {
    try {
      await supabase.from('SubComandas').insert([
        {
          // 'Login' será auto incremental no banco de dados
          'ComandaId': subComanda.comandaId,
          'ValorTotal': subComanda.valorTotal,
          'QuantidadeProdutos': subComanda.quantidadeProdutos,
          'DataLancamento': subComanda.dataLancamento.toIso8601String()
        }
      ]);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<SubComanda>> findAll() async {
    try {
      var responseList = await supabase.from("SubComandas").select('*');
      List<SubComanda> SubComandas = [];

      for (var response in responseList) {
        if (response != null && response is Map<String, dynamic>) {
          SubComanda subcomanda = SubComanda(
              subComandaId: response['SubComandaid'],
              comandaId: response['ComandaId'],
              valorTotal: response['ValorTotal'] is double
                  ? response['ValorTotal']
                  : double.parse(response['ValorTotal'].toString()),
              quantidadeProdutos: response['QuantidadeProdutos'] is int
                  ? response['QuantidadeProdutos']
                  : int.parse(response['QuantidadeProdutos'].toString()),
              dataLancamento:
                  DateTime.parse(response['DataLancamento'].toString()));

          SubComandas.add(subcomanda);
        }
      }

      return SubComandas;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SubComanda?> findBy(id) async {
    try {
      var response = await supabase
          .from('SubComandas')
          .select('*')
          .eq('SubComandaid', id)
          .single();

      // ignore: unnecessary_type_check
      if (response != null && response is Map<String, dynamic>) {
        SubComanda subcomanda = SubComanda(
            subComandaId: response['SubComandaid'],
            comandaId: response['ComandaId'],
            valorTotal: response['ValorTotal'] is double
                ? response['ValorTotal']
                : double.parse(response['ValorTotal'].toString()),
            quantidadeProdutos: response['QuantidadeProdutos'] is int
                ? response['QuantidadeProdutos']
                : int.parse(response['QuantidadeProdutos'].toString()),
            dataLancamento:
                DateTime.parse(response['DataLancamento'].toString()));
        return subcomanda;
      } else {
        throw Exception("Dados do funcionário não encontrados.");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(SubComanda subComanda) async {
    if (SubComanda == null) throw Exception("SubComanda não pode ser null");

    try {
      await supabase.from('SubComandas').update({
        'ValorTotal': subComanda.valorTotal,
        'QuantidadeProdutos': subComanda.quantidadeProdutos,
        'DataLancamento': subComanda.dataLancamento.toIso8601String()
      }).eq('SubComandaid', subComanda.subComandaId.toString());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> remove(SubComanda subcomanda) async {
    try {
      await supabase
          .from('SubComandas')
          .delete()
          .eq('SubComandaid', subcomanda.subComandaId.toString());
    } catch (e) {
      rethrow;
    }
  }
}
