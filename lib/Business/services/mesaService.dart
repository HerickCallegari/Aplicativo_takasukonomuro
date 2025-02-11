import 'package:takasukonomuro/business/repositories/interfaces/iMesaRepository.dart';
import 'package:takasukonomuro/business/repositories/mesaRepository.dart';
import 'package:takasukonomuro/models/mesa.dart';

class MesaService implements IMesaRepository {
  @override
  late MesaRepository repository = MesaRepository();

  @override
  Future<void> add(Mesa? mesa) async {
    if (mesa == null) {
      throw Exception("Mesa esta null.");
    } else if (mesa.descricao == null || mesa.descricao == '') {
      throw Exception("Mesa sem descrição.");
    }
    try {
      repository.add(mesa);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Mesa>> findAll() async {
    try {
      List<Mesa> Lista = await repository.findAll();
      if (Lista == null) {
        throw Exception("Não foi possivel gerar a Lista de Mesas.");
      }
      return Lista;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Mesa?> findBy(String? id) async {
    if (id == null) {
      throw Exception("Mesa Id esta null.");
    }
    try {
      Mesa? mesa = await repository.findBy(id);
      return mesa;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> remove(Mesa? mesa) async {
    if (mesa == null) {
      throw Exception("Mesa esta null.");
    } else if (mesa.mesaId == null) {
      throw Exception("Mesa sem Id.");
    }

    try {
      repository.remove(mesa);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(Mesa? mesa) async {
    if (mesa == null) {
      throw Exception("Mesa esta null.");
    } else if (mesa.mesaId == null) {
      throw Exception("Mesa sem Id.");
    } else if (mesa.descricao == null || mesa.descricao == '') {
      throw Exception("Mesa sem descrição.");
    }

    try {
      repository.update(mesa);
    } catch (e) {
      rethrow;
    }
  }
}
