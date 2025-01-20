// ignore_for_file: unnecessary_null_comparison

import 'package:takasukonomuro/business/repositories/interfaces/iMesaRepository.dart';
import 'package:takasukonomuro/main.dart';
import 'package:takasukonomuro/models/mesa.dart';
import 'package:takasukonomuro/models/enums/status.dart';

class MesaRepository implements IMesaRepository {
  @override
  Future<void> add(Mesa mesa) async {
    try {
      await supabase.from('Mesas').insert([
        {
          // 'Login' será auto incremental no banco de dados
          'Descricao': mesa.descricao,
          'Status': mesa.getStatus()
        }
      ]);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Mesa>> findAll() async {
    try {
      var responseList = await supabase.from("Mesas").select('*');
      List<Mesa> Mesas = [];

      for (var response in responseList) {
        if (response != null && response is Map<String, dynamic>) {
          Mesa mesa = Mesa(
            mesaId: response['MesaId'],
            descricao: response['Descricao'],
            status: _getStatus(response),
          );

          Mesas.add(mesa);
        }
      }

      return Mesas;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Mesa?> findBy(id) async {
    try {
      var response =
          await supabase.from('Mesas').select('*').eq('MesaId', id).single();

      // ignore: unnecessary_type_check
      if (response != null && response is Map<String, dynamic>) {
        Mesa mesa = Mesa(
            mesaId: response['MesaId'],
            descricao: response['Descricao'],
            status: _getStatus(response));
        return mesa;
      } else {
        throw Exception("Dados do funcionário não encontrados.");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(Mesa mesa) async {
    if (Mesa == null) throw Exception("Mesa não pode ser null");

    try {
      await supabase
          .from('Mesas')
          .update({'Descricao': mesa.descricao, 'Status': mesa.getStatus()}).eq(
              'MesaId', mesa.mesaId.toString());
    } catch (e) {
      rethrow;
    }
  }

  Future<Mesa?> testFetchMesa() async {
    var response = await supabase.from('Mesas').select().limit(1).single();

    var data = response as Map;
    try {
      if (data != null && data is Map<String, dynamic>) {
        Mesa mesa = Mesa(
          mesaId: response['MesaId'],
          descricao: response['Descricao'],
          status: _getStatus(response),
        );
        return mesa;
      } else {
        throw Exception("Dados do Funcionario nao encontrados");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> remove(Mesa mesa) async {
    try {
      await supabase
          .from('Mesas')
          .delete()
          .eq('MesaId', mesa.mesaId.toString());
    } catch (e) {
      rethrow;
    }
  }

  Status _getStatus(Map data) {
    try {
      Status status;
      if (data['Status'] == 'Livre') {
        status = Status.Livre;
      } else if (data['Status'] == 'Reservado') {
        status = Status.Reservado;
      } else if (data['Status'] == 'Ocupado') {
        status = Status.Ocupado;
      } else
        throw Exception("Mesa sem cargo");
      return status;
    } catch (e) {
      rethrow;
    }
  }
}
