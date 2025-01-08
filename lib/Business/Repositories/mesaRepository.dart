// ignore_for_file: unnecessary_null_comparison

import 'package:takasukonomuro/business/repositories/interfaces/IMesaRepository.dart';
import 'package:takasukonomuro/main.dart';
import 'package:takasukonomuro/models/Mesa.dart';
import 'package:takasukonomuro/models/enums/status.dart';

class MesaRepository implements IMesaRepository {
  @override
  Future<void> add(Mesa mesa) async {
    try {
      await supabase.from('Mesas').insert([
        {
          // 'Login' será auto incremental no banco de dados
          'descricao': mesa.descricao,
          'status': mesa.getStatus()
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
            id: response['id'],
            descricao: response['descricao'],
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
          await supabase.from('Mesas').select('*').eq('id', id).single();

      // ignore: unnecessary_type_check
      if (response != null && response is Map<String, dynamic>) {
        Mesa mesa = Mesa(
            id: response['id'],
            descricao: response['descricao'],
            status: _getStatus(response));
        return mesa;
      } else {
        print("Dados do funcionário não encontrados.");
        return null;
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
          .update({'descricao': mesa.descricao, 'status': mesa.getStatus()}).eq(
              'id', mesa.id.toString());
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
          id: response['id'],
          descricao: response['descricao'],
          status: _getStatus(response),
        );
        return mesa;
      } else {
        print("Dados do funcionário não encontrados.");
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Status _getStatus(Map data) {
    Status status;
    if (data['status'] == 'Livre') {
      status = Status.Livre;
    } else if (data['status'] == 'Reservado') {
      status = Status.Reservado;
    } else if (data['status'] == 'Ocupado') {
      status = Status.Ocupado;
    } else
      throw Exception("Mesa sem cargo");
    return status;
  }
}
