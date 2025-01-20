// ignore_for_file: unnecessary_null_comparison

import 'package:takasukonomuro/business/repositories/interfaces/iTransacaoRepository.dart';
import 'package:takasukonomuro/main.dart';
import 'package:takasukonomuro/models/transacao.dart';

class TransacaoRepository implements ITransacaoRepository {
  @override
  Future<void> add(Transacao transacao) async {
    try {
      await supabase.from('Transacoes').insert([
        {
          // 'TransacaoId' será auto incremental no banco de dados
          'Valor': transacao.valor,
          'Data': transacao.data,
          'ComandaId': transacao.comandaId,
          'TipoTransacao': transacao.tipoTransacao
        }
      ]);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Transacao>> findAll() async {
    try {
      var responseList = await supabase.from("Transacaos").select('*');
      List<Transacao> Transacaos = [];

      for (var response in responseList) {
        if (response != null && response is Map<String, dynamic>) {
          Transacao transacao = Transacao(
              transacaoId: response['TransacaoId'],
              valor: response['Valor'],
              data: response['Data'],
              comandaId: response['ComandaId'],
              tipoTransacao: response['TipoTransacao']);

          Transacaos.add(transacao);
        }
      }

      return Transacaos;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Transacao?> findBy(id) async {
    try {
      var response = await supabase
          .from('Transacaos')
          .select('*')
          .eq('TransacaoId', id)
          .single();

      // ignore: unnecessary_type_check
      if (response != null && response is Map<String, dynamic>) {
        Transacao transacao = Transacao(
            transacaoId: response['TransacaoId'],
            valor: response['Valor'],
            data: response['Data'],
            comandaId: response['ComandaId'],
            tipoTransacao: response['TipoTransacao']);
        return transacao;
      } else {
        throw Exception("Dados do funcionário não encontrados.");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(Transacao transacao) async {
    if (Transacao == null) throw Exception("Transacao não pode ser null");

    try {
      await supabase.from('Transacaos').update({
        'Valor': transacao.valor,
        'Data': transacao.data,
        'ComandaId': transacao.comandaId,
        'TipoTransacao': transacao.tipoTransacao
      }).eq('TransacaoId', transacao.transacaoId.toString());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> remove(Transacao transacao) async {
    try {
      await supabase
          .from('Transacaos')
          .delete()
          .eq('TransacaoId', transacao.transacaoId.toString());
    } catch (e) {
      rethrow;
    }
  }
}
