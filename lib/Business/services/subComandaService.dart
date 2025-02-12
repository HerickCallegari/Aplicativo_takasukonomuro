import 'package:takasukonomuro/business/repositories/interfaces/iSubComandaRepository.dart';
import 'package:takasukonomuro/business/repositories/subComandaRepository.dart';
import 'package:takasukonomuro/models/subComanda.dart';

class SubComandaService implements ISubComandaRepository {
  @override
  late SubComandaRepository repository = SubComandaRepository();

  @override
  Future<void> add(SubComanda? subComanda) async {
    if (subComanda == null) {
      throw Exception("A subComanda esta null.");
    } else if (subComanda.dataLancamento == null) {
      throw Exception("A data de lançamento esta null.");
    } else if (subComanda.quantidadeProdutos == null) {
      throw Exception("A quantidad de itens esta null.");
    } else if (subComanda.comandaId == null) {
      throw Exception("A subComanda esta sem comanda.");
    } else if (subComanda.valorTotal == null) {
      throw Exception("A SubComanda esta sem total.");
    }

    try {
      repository.add(subComanda);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<SubComanda>> findAll() async {
    List<SubComanda> lista;
    try {
      lista = await repository.findAll();
    } catch (e) {
      rethrow;
    }
    if (lista == null) {
      throw Exception("Não foi possivel obter a lista de SubComandas");
    }
    return lista;
  }

  @override
  Future<SubComanda?> findBy(String? id) {
    if (id == null || id == '') {
      throw Exception("Id null");
    }
    try {
      return repository.findBy(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> remove(SubComanda subComanda) async {
    if (subComanda == null || subComanda.subComandaId == null) {
      throw Exception("subComanda sem id.");
    }
    try {
      repository.remove(subComanda);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(SubComanda subComanda) async {
    if (subComanda == null) {
      throw Exception("A subComanda esta null.");
    } else if (subComanda.dataLancamento == null) {
      throw Exception("A data de lançamento esta null.");
    } else if (subComanda.quantidadeProdutos == null) {
      throw Exception("A quantidad de itens esta null.");
    } else if (subComanda.comandaId == null) {
      throw Exception("A subComanda esta sem comanda.");
    } else if (subComanda.valorTotal == null) {
      throw Exception("A SubComanda esta sem total.");
    } else if (subComanda.subComandaId == null) {
      throw Exception("A SubComanda esta sem ID.");
    }

    try {
      repository.update(subComanda);
    } catch (e) {
      rethrow;
    }
  }
}
