// ignore_for_file: unnecessary_null_comparison

import 'package:takasukonomuro/business/repositories/interfaces/iComandaRepository.dart';
import 'package:takasukonomuro/main.dart';
import 'package:takasukonomuro/models/comanda.dart';

class ComandaRepository implements IComandaRepository {
  @override
  Future<void> add(Comanda comanda) async {
    try {
      await supabase.from('Comandas').insert([
        {
          // 'ComandaId' será auto incremental no banco de dados
          'MesaId': comanda.mesaId,
          'FuncionarioId': comanda.funcionarioId,
          'Data': comanda.data.toIso8601String(),
          'HorarioAbertura': comanda.horarioAbertura.toIso8601String(),
          'ValorTotal': comanda.valorTotal,
          'Pago': comanda.pago
        }
      ]);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Comanda>> findAll() async {
    try {
      var responseList = await supabase.from("Comandas").select('*');
      List<Comanda> Comandas = [];

      for (var response in responseList) {
        if (response != null && response is Map<String, dynamic>) {
          Comanda comanda = Comanda(
              comandaId: response['ComandaId'],
              mesaId: response['MesaId'],
              funcionarioId: response['FuncionarioId'],
              data: response['Data'],
              horarioAbertura: response['HorarioAbertura'],
              horarioFechamento: response['HorarioFechamento'],
              valorTotal: response['ValorTotal'],
              pago: response['Pago']);

          Comandas.add(comanda);
        }
      }

      return Comandas;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Comanda?> findBy(id) async {
    try {
      var response = await supabase
          .from('Comandas')
          .select('*')
          .eq('ComandaId', id)
          .single();

      // ignore: unnecessary_type_check
      if (response != null && response is Map<String, dynamic>) {
        Comanda comanda = Comanda(
            comandaId: response['ComandaId'],
            mesaId: response['MesaId'],
            funcionarioId: response['FuncionarioId'],
            data: response['Data'],
            horarioAbertura: response['HorarioAbertura'],
            horarioFechamento: response['HorarioFechamento'],
            valorTotal: response['ValorTotal'],
            pago: response['Pago']);
        return comanda;
      } else {
        throw Exception("Dados do funcionário não encontrados.");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(Comanda comanda) async {
    if (Comanda == null) throw Exception("Comanda não pode ser null");

    try {
      await supabase.from('Comandas').update({
        'MesaId': comanda.mesaId,
        'FuncionarioId': comanda.funcionarioId,
        'Data': comanda.data.toIso8601String(),
        'HorarioAbertura': comanda.horarioAbertura.toIso8601String(),
        'HorarioFechamento': comanda.horarioFechamento?.toIso8601String(),
        'ValorTotal': comanda.valorTotal,
        'Pago': comanda.pago
      }).eq('ComandaId', comanda.comandaId.toString());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> remove(Comanda comanda) async {
    try {
      await supabase
          .from('Comandas')
          .delete()
          .eq('ComandaId', comanda.comandaId.toString());
    } catch (e) {
      rethrow;
    }
  }
}
