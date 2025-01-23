// ignore_for_file: unnecessary_null_comparison

import 'package:takasukonomuro/business/repositories/interfaces/iTransacaoRepository.dart';
import 'package:takasukonomuro/main.dart';
import 'package:takasukonomuro/models/enums/tipoTransacao.dart';
import 'package:takasukonomuro/models/transacao.dart';

class TransacaoRepository implements ITransacaoRepository {
  @override
  Future<void> add(Transacao transacao) async {
    try {
      await supabase.from('Transacoes').insert([
        {
          // 'TransacaoId' será auto incremental no banco de dados
          'Valor': transacao.valor,
          'Data': transacao.data.toIso8601String(),
          'ComandaId': transacao.comandaId,
          'TipoTransacao': transacao.getTipoTransacao()
        }
      ]);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Transacao>> findAll() async {
    try {
      var responseList = await supabase.from("Transacoes").select('*');
      List<Transacao> Transacaos = [];

      for (var response in responseList) {
        if (response != null && response is Map<String, dynamic>) {
          Transacao transacao = Transacao(
              transacaoId: response['TransacaoId'],
              valor: response['Valor'] is double
                  ? response['Valor']
                  : double.parse(response['Valor'].toString()),
              data: DateTime.parse(response['Data']),
              comandaId: response['ComandaId'],
              tipoTransacao: _getTipotransacao(response));

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
          .from('Transacoes')
          .select('*')
          .eq('TransacaoId', id)
          .single();

      // ignore: unnecessary_type_check
      if (response != null && response is Map<String, dynamic>) {
        Transacao transacao = Transacao(
            transacaoId: response['TransacaoId'],
            valor: response['Valor'] is double
                ? response['Valor']
                : double.parse(response['Valor'].toString()),
            data: DateTime.parse(response['Data']),
            comandaId: response['ComandaId'],
            tipoTransacao: _getTipotransacao(response));
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
      await supabase.from('Transacoes').update({
        'Valor': transacao.valor,
        'Data': transacao.data.toIso8601String(),
        'ComandaId': transacao.comandaId,
        'TipoTransacao': transacao.getTipoTransacao(),
      }).eq('TransacaoId', transacao.transacaoId.toString());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> remove(Transacao transacao) async {
    try {
      await supabase
          .from('Transacoes')
          .delete()
          .eq('TransacaoId', transacao.transacaoId.toString());
    } catch (e) {
      rethrow;
    }
  }

  Tipotransacao _getTipotransacao(Map data) {
    try {
      Tipotransacao tipoTransacao;
      if (data['TipoTransacao'] == 'Credito') {
        tipoTransacao = Tipotransacao.Credito;
      } else if (data['TipoTransacao'] == 'Debito') {
        tipoTransacao = Tipotransacao.Debito;
      } else if (data['TipoTransacao'] == 'Dinheiro') {
        tipoTransacao = Tipotransacao.Dinheiro;
      } else if (data['TipoTransacao'] == 'Pix') {
        tipoTransacao = Tipotransacao.Pix;
      } else if (data['TipoTransacao'] == 'Outro') {
        tipoTransacao = Tipotransacao.Outro;
      } else
        throw Exception("transacao sem tipo ");
      return tipoTransacao;
    } catch (e) {
      rethrow;
    }
  }
}
